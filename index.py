import pymysql
import re

conn = pymysql.connect(host='172.17.0.1', port=3306, user='root',
                       passwd='JBiXwMlP9h6@AJ^1', db='onlinetest', charset='utf8mb4')
p = re.compile(r'\s')
cur = conn.cursor()
cur.execute('select TABLE_NAME, VIEW_DEFINITION from  information_schema.VIEWS where TABLE_SCHEMA = %s ', 'onlinetest')
rs = cur.fetchall()
cur.close()
conn.close()

file_object = open('view.sql', 'w+')
for al in rs:
    file_object.write('DROP VIEW IF EXISTS `' + al[0] + '`;\n')
    file_object.write('CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `' + al[0] +
                      '` AS ' + al[1] + '`;\n\n')

file_object.close()
