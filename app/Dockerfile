# =============================================================================
# Multi-stage Dockerfile for the Flask application
# =============================================================================
# Stage 1 (builder): installs dependencies into a virtual environment.
# Stage 2 (runtime): copies only the virtual environment and source code,
# excluding build tools, compilers, and pip cache.
#
# Base image pinned by SHA256 digest for reproducibility and supply-chain
# integrity. The tag python:3.13-slim would point to different images over
# time as the tag is rebuilt by the official pipeline.
# =============================================================================

# -----------------------------------------------------------------------------
# Build arguments injected at build time
# -----------------------------------------------------------------------------
ARG APP_VERSION=unknown
ARG GIT_SHA=unknown

# =============================================================================
# Stage 1 - builder
# =============================================================================
FROM python@sha256:d168b8d9eb761f4d3fe305ebd04aeb7e7f2de0297cec5fb2f8f6403244621664 AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /build

# Create a dedicated virtual environment inside the image. Keeping the venv
# separate from the system Python makes the runtime copy step explicit and
# avoids polluting the system site-packages.
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --requirement requirements.txt

# =============================================================================
# Stage 2 - runtime
# =============================================================================
FROM python@sha256:d168b8d9eb761f4d3fe305ebd04aeb7e7f2de0297cec5fb2f8f6403244621664 AS runtime

ARG APP_VERSION
ARG GIT_SHA

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH" \
    APP_VERSION=${APP_VERSION} \
    GIT_SHA=${GIT_SHA}

# Create a non-root user with a high numeric UID. UID 10001 sits above the
# typical system range (ending at 999) and outside the default user range
# starting at 1000, reducing collision risk with host UIDs when the Pod
# Security Standards restricted profile enforces runAsNonRoot.
RUN groupadd --system --gid 10001 appuser \
    && useradd --system --uid 10001 --gid appuser --no-create-home --shell /sbin/nologin appuser

WORKDIR /app

# Copy the virtual environment from the builder stage.
COPY --from=builder /opt/venv /opt/venv

# Copy application source code with correct ownership.
COPY --chown=appuser:appuser src/ ./src/

USER appuser

EXPOSE 8000

# Exec form ensures gunicorn receives signals correctly (SIGTERM for graceful
# shutdown). Bound to 0.0.0.0 so the container accepts external connections.
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "src.main:app"]
