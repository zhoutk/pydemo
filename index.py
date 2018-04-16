import pymysql
import json
import time

with open("./configs.json", "r") as configs:
    confs = json.load(configs)
    workDir = confs["workDir"]
    conf = confs["db_rds_strest"]

conn = pymysql.connect(
    host=conf["db_host"],
    port=conf["db_port"],
    user=conf["db_username"],
    passwd=conf["db_password"],
    db=conf["db_database"],
    charset=conf["db_charset"])


def process_rely(parmas={}, rely_old=[]):
    _rely = []
    _keys = list(parmas.keys())
    for k in rely_old:
        for bl in _keys:
            if str(parmas[k]).find(bl) > -1:
                if bl not in _rely:
                    if k not in _rely:
                        _rely.append(bl)
                    else:
                        i = _rely.index(k)
                        _rely.insert(i, bl)
                else:
                    if k in _rely:
                        i = _rely.index(k)
                        j = _rely.index(bl)
                        if i < j:
                            del _rely[j]
                            _rely.insert(i, bl)
        if k not in _rely:
            _rely.append(k)
    return _rely

file_object = open(workDir +
                   conf["db_database"] + '-' +
                   time.strftime("%Y-%m-%d", time.localtime()) +
                   '.sql', 'wb+')
file_object.write(('/*   Mysql export' +
                   '\n\n     Host: ' + conf["db_host"] +
                   '\n     Port: ' + str(conf["db_port"]) +
                   '\n     DataBase: ' + conf["db_database"] +
                   '\n     Date: ' +
                   time.strftime("%Y-%m-%d %H:%M:%S",
                                 time.localtime()) +
                   '\n\n     Author: zhoutk@189.cn' +
                   '\n     Copyright: tlwl-2018' +
                   '\n*/\n\n').encode('UTF-8'))
file_object.write('SET FOREIGN_KEY_CHECKS=0;\n\n'.encode('UTF-8'))

cur = conn.cursor()
cur.execute('select CONSTRAINT_NAME,TABLE_NAME,COLUMN_NAME,REFERENCED_TABLE_SCHEMA,' +
            'REFERENCED_TABLE_NAME,REFERENCED_COLUMN_NAME from information_schema.`KEY_COLUMN_USAGE` ' +
            'where REFERENCED_TABLE_SCHEMA = %s ',
            conf["db_database"])
cstRs = cur.fetchall()
cur.close()

FKEYS = {}
for cstAl in cstRs:
    FKEYS[cstAl[1] + '.' + cstAl[2]] = {
        "constraintName": cstAl[0],
        "colName1": cstAl[2],
        "schema": cstAl[3],
        "tableName": cstAl[4],
        "colName2": cstAl[5]
    }

cur = conn.cursor()
cur.execute('select TABLE_NAME,ENGINE,ROW_FORMAT,AUTO_INCREMENT,TABLE_COLLATION,CREATE_OPTIONS,TABLE_COMMENT' +
            ' from information_schema.`TABLES` ' +
            'where TABLE_SCHEMA = %s and TABLE_TYPE = %s ' +
            'order by TABLE_NAME',
            (conf["db_database"], 'BASE TABLE'))
tbRs = cur.fetchall()
cur.close()

for tbAl in tbRs:
    cur = conn.cursor()
    cur.execute('SELECT	`COLUMNS`.COLUMN_NAME,`COLUMNS`.COLUMN_TYPE,`COLUMNS`.IS_NULLABLE,' +
                '`COLUMNS`.CHARACTER_SET_NAME,`COLUMNS`.COLUMN_DEFAULT,`COLUMNS`.EXTRA,' +
                '`COLUMNS`.COLUMN_KEY,`COLUMNS`.COLUMN_COMMENT,`STATISTICS`.TABLE_NAME,' +
                '`STATISTICS`.INDEX_NAME,`STATISTICS`.SEQ_IN_INDEX,`STATISTICS`.NON_UNIQUE,' +
                '`COLUMNS`.COLLATION_NAME ' +
                'FROM information_schema.`COLUMNS` ' +
                'LEFT JOIN information_schema.`STATISTICS` ON ' +
                'information_schema.`COLUMNS`.TABLE_NAME = `STATISTICS`.TABLE_NAME ' +
                'AND information_schema.`COLUMNS`.COLUMN_NAME = information_schema.`STATISTICS`.COLUMN_NAME ' +
                'AND information_schema.`STATISTICS`.table_schema = %s ' +
                'where information_schema.`COLUMNS`.TABLE_NAME = %s and `COLUMNS`.table_schema = %s ',
                (conf["db_database"], tbAl[0], conf["db_database"]))
    colRs = cur.fetchall()
    cur.close()
    tableName = tbAl[0]
    tableEngine = tbAl[1]
    tableRowFormat = tbAl[2]
    tableAutoIncrement = tbAl[3]
    tableCollation = tbAl[4]
    tableCharset = tableCollation.split('_')[0]
    tableCreateOptions = tbAl[5]
    tableComment = tbAl[6]

    file_object.write(('DROP TABLE IF EXISTS `' + tbAl[0] + '`;\n').encode('UTF-8'))
    file_object.write(('CREATE TABLE `' + tableName + '` (\n').encode('UTF-8'))
    priKey = {}
    colKey = {}
    mulKey = {}
    fKey = []
    priIndex = 1
    theTableColSet = {}
    allFields = []
    for colAl in colRs:
        if colAl[0] not in theTableColSet:
            theTableColSet[colAl[0]] = 1
            allFields.append(colAl[0])
            if colAl[4] is None:
                defaultValue = None
            else:
                defaultValue = colAl[4] if colAl[4] == 'CURRENT_TIMESTAMP' else '\'' + colAl[4] + '\''
            file_object.write(('  `' + colAl[0] + '` ' + colAl[1] +
                              (' CHARACTER SET ' + colAl[3] if colAl[3] and colAl[3] != tableCharset else '') +
                              (' COLLATE ' + colAl[12] if colAl[12] and colAl[12] != tableCollation else '') +
                              (' NOT NULL' if colAl[2] == 'NO' else '') +
                              (' DEFAULT ' + defaultValue if colAl[4] is not None else
                              ('' if colAl[2] == 'NO' else ' DEFAULT NULL')) +
                              (' ' + colAl[5] if colAl[5] else '') +
                              (' COMMENT \'' + colAl[7] + '\'' if colAl[7] else '') +
                              ',\n').encode('UTF-8'))
            if tableName+'.'+colAl[0] in FKEYS:
                fKey.append(FKEYS[tableName+'.'+colAl[0]])
        if colAl[9] and colAl[9] == 'PRIMARY':
            if colAl[9] not in priKey:
                priKey[colAl[9]] = []
            priKey[colAl[9]].append(colAl[0])
        elif colAl[9] and colAl[11] == 0:
            if colAl[9] not in colKey:
                colKey[colAl[9]] = []
            colKey[colAl[9]].append(colAl[0])
        elif colAl[9] and colAl[11] == 1:
            if colAl[9] not in mulKey:
                mulKey[colAl[9]] = []
            mulKey[colAl[9]].append(colAl[0])

    for prikey in priKey.keys():
        file_object.write(('  PRIMARY KEY (`'+"`,`".join(priKey[prikey])+'`),\n').encode('UTF-8'))
    for ckey in colKey.keys():
        file_object.write(('  UNIQUE KEY `'+ckey+'` (`'+"`,`".join(colKey[ckey])+'`),\n').encode('UTF-8'))
    for mkey in mulKey.keys():
        file_object.write(('  KEY `'+mkey+'` (`'+"`,`".join(mulKey[mkey])+'`),\n').encode('UTF-8'))
    for fkey in fKey:
        file_object.write(('  CONSTRAINT `'+fkey["constraintName"]+'` FOREIGN KEY (`'+fkey["colName1"] +
                          '`) REFERENCES `'+fkey["tableName"]+'` (`'+fkey["colName2"]+'`),\n').encode('UTF-8'))
    file_object.seek(-len(',\n'), 1)
    file_object.write((
        '\n) ENGINE=' + tableEngine +
        (' AUTO_INCREMENT=' + str(tableAutoIncrement) if tableAutoIncrement is not None else '') +
        ' DEFAULT CHARSET=' + tableCharset + (' COLLATE=' + tableCollation if tableCollation else '') +
        ' ' + tableCreateOptions + ' COMMENT=\'' + tableComment + '\';\n\n').encode('UTF-8')
    )
    cur = conn.cursor()
    # cur.execute('SET NAMES utf8mb4')
    # cur.execute("SET CHARACTER SET utf8mb4")
    # cur.execute("SET character_set_connection=utf8mb4")
    cur.execute('select ' + ",".join(allFields) + ' from ' + tableName)
    recordsRs = cur.fetchall()
    cur.close()
    for ele in recordsRs:
        file_object.write(('INSERT INTO `'+tableName+'` VALUES (').encode('UTF-8'))
        for el in ele:
            file_object.write(
                (("null" if el is None else "'" + pymysql.escape_string(str(el)) + "'") +
                 ",").encode('UTF-8'))
        file_object.seek(-1, 1)
        file_object.write((");\n").encode('UTF-8'))
    file_object.write(("\n").encode('UTF-8'))

cur = conn.cursor()
cur.execute('select TABLE_NAME, VIEW_DEFINITION from ' +
            ' information_schema.VIEWS where TABLE_SCHEMA = %s ',
            conf["db_database"])
rs = cur.fetchall()
cur.close()

ps = {}
for al in rs:
    ps['`' + al[0] + '`'] = al[1]

rely1 = process_rely(ps, list(ps.keys()))
rely = process_rely(ps, rely1)                  # 第二次迭代

for al in rely:
    file_object.write(('DROP VIEW IF EXISTS ' + al + ';\n').encode('UTF-8'))
    file_object.write((
        'CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` ' +
        ' SQL SECURITY DEFINER VIEW ' + al + ' AS ' + ps[al] + ';\n\n').encode('UTF-8'))

cur = conn.cursor()
cur.execute('select name,type,param_list,returns,body from mysql.proc where db = %s ', conf["db_database"])
fRs = cur.fetchall()
cur.close()
for cstAl in fRs:
    file_object.write(('DROP PROCEDURE IF EXISTS `'+cstAl[0]+'`;\n').encode('UTF-8'))
    file_object.write(('DELIMITER ;;\n').encode('UTF-8'))
    file_object.write(('CREATE DEFINER=`root`@`%` '+cstAl[1]+' `'+cstAl[0] +
                       '`('+(str(cstAl[2], encoding='utf-8')) +
                       ')'+(' RETURNS ' + str(cstAl[3], encoding='utf-8') if cstAl[3] else '')+'\n').encode('UTF-8'))
    file_object.write((str(cstAl[4], encoding='utf-8') + "\n").encode('UTF-8'))
    file_object.write((';;\nDELIMITER ;\n\n').encode('UTF-8'))

file_object.close()
conn.close()
