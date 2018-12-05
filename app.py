from flask import Flask, Response
from db_connector import DbConnector
import simplejson
from collections import defaultdict
from decimal import Decimal

app = Flask(__name__)


@app.route('/raised_amount', methods=['GET'])
def raised_amount():
    db_connector = DbConnector()

    file = open('sql_scripts/raised_amount.sql', 'r')
    sql_query = file.read()
    file.close()

    spreadsheet = db_connector.execute_query(sql_query)

    raised_amount = defaultdict(Decimal)
    spreadsheet.pop(0)

    for line in spreadsheet:
        raised_amount[line[0]] += line[1]

    json = simplejson.dumps(raised_amount, use_decimal=True, sort_keys=True)

    resp = Response(json, status=200, mimetype='application/json')

    return resp


if __name__ == '__main__':
    app.run()
