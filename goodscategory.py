import pymysql
import xlrd
import json
import uuid

with open("./configs.json", 'r', encoding='utf-8') as json_file:
    dbconf = json.load(json_file)['db_online_chz']

conn = pymysql.connect(host=dbconf['db_host'], port=dbconf['db_port'], user=dbconf['db_username'],
                       passwd=dbconf['db_password'], db=dbconf['db_database'], charset=dbconf['db_charset'])

data = xlrd.open_workbook('./member.xlsx')
table = data.sheets()[0]
# t = table.col_values(1)
nrows = table.nrows
ops = []
ops2 = []
for i in range(nrows):
    if i > 1:
        r = table.row_values(i)
        phone = int(r[0])
        realname = r[1]
        nickname = r[2]
        id_number = r[3]
        rank = r[4]
        live_city = '长治市'

        main_id = str(uuid.uuid1()).split('-')[0]
        ops.append((main_id, phone, phone, realname, nickname, id_number, 0, live_city))
        ops2.append((main_id, rank))

cur = conn.cursor()
cur.executemany('insert into `member` (`id`, `username`, `phone`, `realname`, `nickname`, `id_number`, `rank`, `live_city`) \
                 values (%s, %s, %s, %s, %s, %s, %s, %s)', ops)
cur.executemany('insert into `02_member` (`id`, `rank`) \
                 values (%s, %s)', ops2)
conn.commit()
cur.close()

