from flask import Flask, Response
from db_connector import DbConnector
import simplejson

app = Flask(__name__)
db_connector = DbConnector()


def get_sql_query(file_path):
    file = open(file_path, 'r')
    sql_query = file.read()
    file.close()
    return sql_query


def get_sql_results(sql_query):
    query_result = db_connector.execute_query(sql_query)

    json = simplejson.dumps(dict(query_result), use_decimal=True, sort_keys=True)

    response = Response(json, status=200, mimetype='application/json')

    return response


@app.route('/raised_amount', methods=['GET'])
def raised_amount():
    response = get_sql_results(get_sql_query('sql_scripts/raised_amount.sql'))

    return response


@app.route('/approved_amount', methods=['GET'])
def approved_amount():
    response = get_sql_results(get_sql_query('sql_scripts/approved_amount.sql'))

    return response

@app.route('/proponent_count', methods=['GET'])
def proponent_count():
    response = get_sql_results(get_sql_query('sql_scripts/proponent_count.sql'))

    return response


if __name__ == '__main__':
    app.run()
