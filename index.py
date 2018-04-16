import pymysql
import json
import time
from exportMysql import exportMysql

with open("./configs.json", "r") as configs:
    confs = json.load(configs)
    workDir = confs["workDir"]

for confKey in confs:
    if not confKey.startswith('db_'):
        continue
    else:
        conf = confs[confKey]
    try:
        exportMysql(conf, workDir)
    except Exception as err:
        error = err
    finally:
        print(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()),
              '[error] export ' + conf["db_database"] + ' failure. message:' +
              str(error) if 'error' in dir() else '[info] export ' +
              conf["db_database"] + ' success.')
