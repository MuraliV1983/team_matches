import pymysql

def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='server',
        database='world_new',
        cursorclass=pymysql.cursors.DictCursor
    )