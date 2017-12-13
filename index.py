import pymysql

conn = pymysql.connect(host='172.17.0.1', port=3306, user='root',
                       passwd='JBiXwMlP9h6@AJ^1', db='onlinetest', charset='utf8mb4')


def process_rely(parmas={}):
    _rely = []
    _keys = list(parmas.keys())
    for (k, v) in parmas.items():
        for bl in _keys:
            if str(v).find(bl) > -1:
                if bl not in _rely:
                    if k not in _rely:
                        _rely.append(bl)
                    else:
                        i = _rely.index(k)
                        _rely.insert(i, bl)
        if k not in _rely:
            _rely.append(k)
    return _rely


cur = conn.cursor()
cur.execute('select TABLE_NAME, VIEW_DEFINITION from  information_schema.VIEWS where TABLE_SCHEMA = %s ', 'onlinetest')
rs = cur.fetchall()
cur.close()
conn.close()

ps = {}
for al in rs:
    ps['`' + al[0] + '`'] = al[1]

rely = process_rely(ps)



file_object = open('view.sql', 'w')
for al in rely:
    file_object.write('DROP VIEW IF EXISTS ' + al + ';\n')
    file_object.write('CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW ' + al +
                      ' AS ' + ps[al] + ';\n\n')

file_object.close()
