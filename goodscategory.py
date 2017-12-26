import pymysql
import xlrd
import json

with open("./configs.json", 'r', encoding='utf-8') as json_file:
    dbconf = json.load(json_file)['db_local_onlinetest']

conn = pymysql.connect(host=dbconf['db_host'], port=dbconf['db_port'], user=dbconf['db_username'],
                       passwd=dbconf['db_password'], db=dbconf['db_database'], charset=dbconf['db_charset'])

data = xlrd.open_workbook('./goods.xlsx')
table = data.sheets()[0]
# t = table.col_values(1)
nrows = table.nrows
ops = []
for i in range(nrows):
    if i > 0:
        r = table.row_values(i)
        category = r[4]
        goods_id = r[9]
        ops.append((category, goods_id))

cur = conn.cursor()
cur.executemany('update goods set category = %s where id = %s ', ops)
conn.commit()
cur.close()

