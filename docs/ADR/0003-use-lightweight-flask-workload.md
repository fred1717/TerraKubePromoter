The project needs 2 things: 
- a platform 
- a workload

The platform is the main deliverable:
- EKS cluster provisioned via Terraform
- ArgoCD installed and configured
- Multi-environment promotion via Git (dev → staging → production)
- Each environment in its own namespace with proper RBAC (Role-Based Access Control) and resource quotas.
    In Kubernetes, RBAC is the mechanism that controls which users or service accounts can perform which actions on which resources within the cluster.
    For example, in a multi-environment setup (dev, staging, production), RBAC rules can ensure that:
    - A developer service account can deploy to the dev namespace but not to production
    - ArgoCD has permission to apply manifests in all 3 namespaces
    - No service account has more access than its function requires

This aligns with the least-privilege principle referenced in the README under "namespace isolation."
The workload is secondary:
- it exists only to demonstrate the platform working
- It should be lightweight and realistic:
    For example, a small REST API (Python/Flask, consistent with ITF Masters Tour) with a health endpoint and a version endpoint.:
    - simple enough to not distract from the infrastructure story
    - functional enough to prove the deployment pipeline works
