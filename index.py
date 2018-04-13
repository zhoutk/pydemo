import pymysql
import json
import time

with open("./configs.json", "r") as configs:
    confs = json.load(configs)
    workDir = confs["workDir"]
    conf = confs["db_rds_jyh"]

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

file_object = open(workDir +
                   conf["db_database"] +
                   time.strftime("%Y-%m-%d", time.localtime()) +
                   '.sql', 'w')
for al in rely:
    file_object.write('DROP VIEW IF EXISTS ' + al + ';\n')
    file_object.write(
        'CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` ' +
        ' SQL SECURITY DEFINER VIEW ' + al + ' AS ' + ps[al] + ';\n\n')

file_object.close()
