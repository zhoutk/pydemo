import pymysql

conn = pymysql.connect(host='172.17.0.1', port=3306, user='root',
                       passwd='JBiXwMlP9h6@AJ^1', db='onlinetest', charset='utf8mb4')
cur = conn.cursor()
cur.execute('select TABLE_NAME, VIEW_DEFINITION from  information_schema.VIEWS where TABLE_SCHEMA = %s ', 'onlinetest')
rs = cur.fetchall()
cur.close()
conn.close()

keys = []
ps = {}
for al in rs:
    keys.append('`' + al[0] + '`')
    ps['`' + al[0] + '`'] = al[1]

rely = []
for al in rs:
    for bl in keys:
        if str(al[1]).find(bl) > -1:
            if bl not in rely:
                if '`' + al[0] + '`' not in rely:
                    rely.append(bl)
                else:
                    i = rely.index('`' + al[0] + '`')
                    rely.insert(i, bl)

    if '`' + al[0] + '`' not in rely:
        rely.append('`' + al[0] + '`')

file_object = open('view.sql', 'w')
for al in rely:
    file_object.write('DROP VIEW IF EXISTS ' + al + ';\n')
    file_object.write('CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW ' + al +
                      ' AS ' + ps[al] + ';\n\n')

file_object.close()
