# =============================================================================
# Flask application - health, readiness, and version endpoints
# =============================================================================
# The application is served by gunicorn in production and by `flask run` in
# development. No app.run() block is included, as the WSGI server is the
# entry point in both cases.
#
# Version and git SHA are read from environment variables injected at
# container build time via Docker ARG and ENV directives. Defaults to
# "unknown" if unset, allowing the /version endpoint to succeed during
# local development without the container.
# =============================================================================

import os

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/health", methods=["GET"])
def health():
    """Liveness probe - indicates the application process is running."""
    return jsonify({"status": "healthy"}), 200


@app.route("/ready", methods=["GET"])
def ready():
    """Readiness probe - indicates the application is ready to serve traffic."""
    return jsonify({"status": "ready"}), 200


@app.route("/version", methods=["GET"])
def version():
    """Returns the image version and git SHA injected at build time."""
    return jsonify(
        {
            "version": os.environ.get("APP_VERSION", "unknown"),
            "git_sha": os.environ.get("GIT_SHA", "unknown"),
        }
    ), 200
