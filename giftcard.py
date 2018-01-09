import pymysql
import random

conn = pymysql.connect(host='172.17.0.1', port=3306, user='root',
                       passwd='123456', db='onlinetest', charset='utf8mb4')


def get_n_rand(n):
    rs = []
    for k in range(n):
        rs.append(str(random.randint(0, 9)))
    return rs


def get_rand_pwd(n):
    rs = []
    for k in range(n):
        tt = random.randint(0, 52)
        if tt > 25:
            tt = str(((tt - 26) % 9) + 1)
        else:
            tt = chr(tt + 65)
        rs.append(tt)
    return rs


batnummber = '0105'
ops = []
for i in range(131):
    dd = get_n_rand(6)
    tmp = 'DY' + batnummber + ''.join(dd)
    tmp2 = []
    tmp2.append(tmp[0:4])
    tmp2.append(tmp[4:-4])
    tmp2.append(tmp[8:])

    ops.append((i + 3301, 'DY', batnummber, tmp, ' '.join(tmp2), ''.join(get_rand_pwd(6))))

cur = conn.cursor()
cur.executemany('insert into `gift_card` (`id`, `flag`, `batch`, `card_number`, `show_number`, `password`) \
                 values (%s, %s, %s, %s, %s, %s)', ops)
conn.commit()
cur.close()

conn.close()
