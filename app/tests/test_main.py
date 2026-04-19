# =============================================================================
# Unit tests for the Flask application endpoints
# =============================================================================
# Tests use the Flask test client, which runs the WSGI application in-process
# without a network or a separate server. Standard Flask testing practice.
#
# Reference: https://flask.palletsprojects.com/en/stable/testing/
# =============================================================================

import pytest

from src.main import app


@pytest.fixture
def client():
    """Flask test client reused across all tests in this module."""
    app.config["TESTING"] = True
    with app.test_client() as test_client:
        yield test_client


def test_health_returns_200_and_healthy_status(client):
    """GET /health returns 200 with a healthy status payload."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}


def test_ready_returns_200_and_ready_status(client):
    """GET /ready returns 200 with a ready status payload."""
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.get_json() == {"status": "ready"}


def test_version_returns_200_and_default_unknown_values(client):
    """GET /version returns 200 with unknown defaults when env vars are unset."""
    response = client.get("/version")
    assert response.status_code == 200
    assert response.get_json() == {"version": "unknown", "git_sha": "unknown"}
