# encoding: utf-8
import json
import logging
from flask_script import Manager
from flask import jsonify, request, Response

from project.app import create_app

app = create_app()

manager = Manager(app)

@app.route("/")
def example():
        return jsonify({"main": "hello world"})

@app.route("/test/")
def handle_test():
    action = request.args.get('action', '')
    inh = {}
    for k, v in request.headers.items():
        inh[k] = v
    inh['action'] = action
    resp = json.dumps(inh)
    resp += "\r\n"
    return Response(resp, mimetype='application/json') 


import audit_trail

if __name__ == '__main__':
    manager.run()
