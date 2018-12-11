from flask import Flask, Response, url_for
from db_connector import DbConnector
import simplejson
from collections import defaultdict

app = Flask(__name__)
db_connector = DbConnector()


def get_sql_query(file_path):
    file = open(file_path, 'r')
    sql_query = file.read()
    file.close()
    return sql_query


def get_sql_results(sql_query):
    query_result = db_connector.execute_query(sql_query)
    print(query_result)

    json = simplejson.dumps(dict(query_result), use_decimal=True, sort_keys=True)

    response = Response(json, status=200, mimetype='application/json')

    return response


@app.route('/')
def home():
    urls = url_for('raised_amount') + url_for('proponent_count') + url_for('approved_amount') + '/'

    return urls


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


@app.route('/proponent_complete', methods=['GET'])
def proponent_complete():
    sql_query = get_sql_query('sql_scripts/proponent_complete.sql')
    query_result = db_connector.execute_query(sql_query)

    uf_dict = defaultdict(dict)
    titles = ["Proponentes", "Aprovado", "Captado"]
    for uf_line in query_result:
        uf_dict[uf_line[0]] =  {titles[0]: uf_line[1], titles[1]: uf_line[2], titles[2]: uf_line[3]}

    json = simplejson.dumps(uf_dict, use_decimal=True)

    response = Response(json, status=200, mimetype='application/json')

    return response


if __name__ == '__main__':
    app.run()
