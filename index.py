import pymysql

targetDatabase = 'jyh'
conn = pymysql.connect(
    host='tlwl2020.mysql.rds.aliyuncs.com',
    port=3686,
    user='root',
    passwd='znhl2017UP',
    db=targetDatabase,
    charset='utf8mb4')


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
            targetDatabase)
rs = cur.fetchall()
cur.close()
conn.close()

ps = {}
for al in rs:
    ps['`' + al[0] + '`'] = al[1]

rely1 = process_rely(ps, list(ps.keys()))
rely = process_rely(ps, rely1)                  # 第二次迭代

file_object = open('view.sql', 'w')
for al in rely:
    file_object.write('DROP VIEW IF EXISTS ' + al + ';\n')
    file_object.write(
        'CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` ' +
        ' SQL SECURITY DEFINER VIEW ' + al + ' AS ' + ps[al] + ';\n\n')

file_object.close()
