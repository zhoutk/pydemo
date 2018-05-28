import pymysql
import time


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


def exportMysql(conf, workDir):
    conn = pymysql.connect(
        host=conf["db_host"],
        port=conf["db_port"],
        user=conf["db_username"],
        passwd=conf["db_password"],
        db=conf["db_database"],
        charset=conf["db_charset"])
    file_object = open(workDir +
                       (conf["file_alias"] if "file_alias" in conf else conf["db_database"]) + '-' +
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
        viewStr = ps[al].replace('`'+conf["db_database"]+'`.', '')
        file_object.write(('DROP VIEW IF EXISTS ' + al + ';\n').encode('UTF-8'))
        file_object.write((
            'CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` ' +
            ' SQL SECURITY DEFINER VIEW ' + al + ' AS ' + viewStr + ';\n\n').encode('UTF-8'))

    cur = conn.cursor()
    cur.execute('select name,type,param_list,returns,body from mysql.proc where db = %s ', conf["db_database"])
    fRs = cur.fetchall()
    cur.close()
    for cstAl in fRs:
        file_object.write(('DROP PROCEDURE IF EXISTS `'+cstAl[0]+'`;\n').encode('UTF-8'))
        file_object.write(('DELIMITER ;;\n').encode('UTF-8'))
        file_object.write(('CREATE DEFINER=`root`@`%` '+cstAl[1]+' `'+cstAl[0] +
                           '`('+(str(cstAl[2], encoding='utf-8')) +
                           ')'+(' RETURNS ' + str(cstAl[3], encoding='utf-8') if cstAl[3] else '') +
                           '\n').encode('UTF-8'))
        file_object.write((str(cstAl[4], encoding='utf-8') + "\n").encode('UTF-8'))
        file_object.write((';;\nDELIMITER ;\n\n').encode('UTF-8'))

    file_object.close()
    conn.close()
