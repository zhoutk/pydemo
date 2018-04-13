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
                   '.sql', 'w')
file_object.write('/*   Mysql export' +
                  '\n\n     Host: ' + conf["db_host"] +
                  '\n     Port: ' + str(conf["db_port"]) +
                  '\n     DataBase: ' + conf["db_database"] +
                  '\n     Date: ' +
                  time.strftime("%Y-%m-%d %H:%M:%S",
                                time.localtime()) +
                  '\n\n     Author: zhoutk@189.cn' +
                  '\n     Copyright: tlwl-2018' +
                  '\n*/\n\n')
file_object.write('SET FOREIGN_KEY_CHECKS=0;\n\n')

cur = conn.cursor()
cur.execute('select INDEX_NAME,TABLE_NAME,COLUMN_NAME' +
            ' from information_schema.`STATISTICS` ' +
            'where TABLE_SCHEMA = %s ',
            conf["db_database"])
cstRs = cur.fetchall()
cur.close()

CSTS = {}
for cstAl in cstRs:
    CSTS[cstAl[1]+'.'+cstAl[2]] = cstAl[0]

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
    cur.execute('SELECT COLUMN_NAME,COLUMN_TYPE,IS_NULLABLE,CHARACTER_SET_NAME,COLUMN_DEFAULT,' +
                'EXTRA,COLUMN_KEY,COLUMN_COMMENT FROM ' +
                'INFORMATION_SCHEMA.COLUMNS where table_schema = %s ' +
                'AND table_name = %s ',
                (conf["db_database"], tbAl[0]))
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

    file_object.write('DROP TABLE IF EXISTS `' + tbAl[0] + '`;\n')
    file_object.write('CREATE TABLE `' + tableName + '` (\n')
    priKey = ''
    colKey = []
    mulKey = []
    for colAl in colRs:
        file_object.write('  `' + colAl[0] + '` ' + colAl[1] +
                          (' NOT NULL' if colAl[2] == 'NO' else '') +
                          (' CHARACTER SET ' + colAl[3] if colAl[3] and colAl[3] != tableCharset else '') +
                          (' DEFAULT \'' + colAl[4] + '\'' if colAl[4] is not None else
                          ('' if colAl[2] == 'NO' else ' DEFAULT NULL')) +
                          (' ' + colAl[5] if colAl[5] else '') +
                          (' COMMENT \'' + colAl[7] + '\'' if colAl[7] else '') +
                          ',\n')
        if colAl[6] == 'PRI':
            priKey = colAl[0]
        elif colAl[6] == 'UNI':
            colKey.append({"colName": colAl[0], "alias": CSTS[tableName+'.'+colAl[0]]})
        elif colAl[6] == 'MUL':
            mulKey.append({"colName": colAl[0], "alias": CSTS[tableName+'.'+colAl[0]]})
    if priKey:
        file_object.write('  PRIMARY KEY (`'+priKey+'`),\n')
    for ckey in colKey:
        file_object.write('  UNIQUE KEY `'+ckey["alias"]+'` (`'+ckey["colName"]+'`),\n')
    for mkey in mulKey:
        file_object.write('  KEY `'+mkey["alias"]+'` (`'+mkey["colName"]+'`),\n')
    
    file_object.write(')\n\n')

cur = conn.cursor()
cur.execute('select TABLE_NAME, VIEW_DEFINITION from ' +
            ' information_schema.VIEWS where TABLE_SCHEMA = %s ',
            conf["db_database"])
rs = cur.fetchall()
cur.close()
conn.close()

ps = {}
for al in rs:
    ps['`' + al[0] + '`'] = al[1]

rely1 = process_rely(ps, list(ps.keys()))
rely = process_rely(ps, rely1)                  # 第二次迭代

for al in rely:
    file_object.write('DROP VIEW IF EXISTS ' + al + ';\n')
    file_object.write(
        'CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` ' +
        ' SQL SECURITY DEFINER VIEW ' + al + ' AS ' + ps[al] + ';\n\n')

file_object.close()
