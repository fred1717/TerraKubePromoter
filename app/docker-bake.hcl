# =============================================================================
# Docker Bake build configuration
# =============================================================================
# Codifies the build parameters for the Flask application image. Running
# `docker buildx bake` from the app/ directory reads this file and applies
# the settings below, eliminating flag drift between local builds and
# CI/CD builds.
#
# provenance and sbom are disabled because ECR basic scanning does not
# support OCI image indices. With both attestations disabled, Buildx
# produces a single-platform image manifest that ECR can scan.
#
# Reference: https://docs.docker.com/build/bake/
# Reference: https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning-troubleshooting.html
# =============================================================================

variable "APP_VERSION" {
  default = "0.0.0"
}

variable "GIT_SHA" {
  default = "unknown"
}

variable "IMAGE_NAME" {
  default = "terrakubepromoter-app"
}

group "default" {
  targets = ["app"]
}

target "app" {
  context    = "./app"
  dockerfile = "Dockerfile"

args = {
    APP_VERSION = APP_VERSION
    GIT_SHA     = GIT_SHA
  }

  tags = [
    "${IMAGE_NAME}:${APP_VERSION}",
  ]

  # Attestation controls — required for ECR basic scanning compatibility.
attest = [
  "type=provenance,disabled=true",
  "type=sbom,disabled=true"
]

  # Single-platform build for the target cluster architecture.
  platforms = ["linux/amd64"]
}
