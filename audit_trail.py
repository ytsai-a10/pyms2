import logging

from flask import jsonify, request
from manage import app

@app.route("/audit_trail/", methods=['GET'])
def handle_audit_trail():
    action = request.args.get('action', '')
    app.logger.info("Audit Trail: %s", action)

    return jsonify({"AuditTrail": action})
