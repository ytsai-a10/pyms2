# encoding: utf-8
from flask_script import Manager
from flask import jsonify

from project.app import create_app

app = create_app()

manager = Manager(app)

@app.route("/")
def example():
        return jsonify({"main": "hello world"})

if __name__ == '__main__':
    manager.run()
