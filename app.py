from flask import Flask, Response
from db_connector import DbConnector
import simplejson

app = Flask(__name__)
db_connector = DbConnector()


def get_sql_result(file_path):

    file = open(file_path, 'r')
    sql_query = file.read()
    file.close()
    return sql_query


@app.route('/raised_amount', methods=['GET'])
def raised_amount():
    sql_query = get_sql_result('sql_scripts/raised_amount.sql')

    query_result = db_connector.execute_query(sql_query)

    json = simplejson.dumps(dict(query_result), use_decimal=True, sort_keys=True)

    resp = Response(json, status=200, mimetype='application/json')

    return resp


if __name__ == '__main__':
    app.run()
