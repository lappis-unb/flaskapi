from flask import Flask, jsonify
from db_connector import DbConnector

app = Flask(__name__)




@app.route('/')
def hello_world():
    db_connector = DbConnector()

    file = open('sql_scripts/raised_amount.sql', 'r')
    sql_query = file.read()
    file.close()

    spreadsheet = db_connector.execute_query(sql_query)

    print(spreadsheet[1])

    # return jsonify(spreadsheet)
    return "Hi!"


if __name__ == '__main__':
    app.run()
