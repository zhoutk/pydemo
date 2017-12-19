import pymysql
import xlrd

conn = pymysql.connect(host='101.201.141.70', port=10505, user='root',
                       passwd='JBiXwMlP9h6@AJ^1', db='onlinetest', charset='utf8mb4')


cur = conn.cursor()
cur.execute("select id,category from goods where category > 0 ")
rs = cur.fetchall()
cur.close()
conn.close()

goods = {}
for al in rs:
    goods[al[0]] = al[1]

data = xlrd.open_workbook('./goods.xlsx')
table = data.sheets()[0]
# t = table.col_values(1)
nrows = table.nrows
ops = []
for i in range(nrows):
    if i > 0:
        r = table.row_values(i)
        tmp = r[19] if isinstance(r[19], str) else int(r[19])
        if goods[r[7]] != int(str(tmp)[-3:]):
            print(i+1, ' goodsid: ', r[7], ' old category: ', goods[r[7]], ' new category: ', int(str(tmp)[-3:]))
