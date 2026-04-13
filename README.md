## 0. Context for the `TerraKubePromoter` project
**Option A — GitOps Deployment Platform**
EKS cluster provisioned via Terraform, with ArgoCD managing application delivery from Git.
Demonstrates the separation of infrastructure provisioning (Terraform) from workload delivery (GitOps).
This is the most in-demand Kubernetes pattern in enterprise contracts.

**Option B — Progressive Delivery Pipeline**
EKS cluster with Argo Rollouts or Flagger for canary/blue-green deployments.
Demonstrates zero-downtime release strategy — a natural extension of the DR theme already present in ITF Masters Tour.

**Option C — Hardened Multi-Tenant Cluster**
EKS cluster with namespace isolation, RBAC, network policies, resource quotas, and Pod Security Standards.
Extends the security hardening theme from GoldenPipeline into the Kubernetes domain.

**All 3 share a common base:**
- EKS provisioned via Terraform
- VPC with proper subnet architecture
- GitHub Actions CI/CD
- Full documentation and tagging

**Differences**
- Option A has the widest market appeal
- Option B connects well to the existing DR narrative
- Option C connects well to the existing security narrative

They are also not mutually exclusive:
— A could serve as the base, with elements of B or C layered in. 
- The risk is scope creep within 1 week.

**What ArgoCD does:**
A traditional deployment works like this: 
- a CI/CD pipeline builds a container image
- then pushes it to Kubernetes by running `kubectl apply` or `helm upgrade` commands.

ArgoCD reverses that flow. 
Instead of the pipeline pushing changes into the cluster, ArgoCD sits inside the cluster and continuously watches a Git repository. When a Kubernetes manifest file changes in that repository, ArgoCD detects the difference and applies it automatically. 
If someone changes something directly in the cluster (a manual `kubectl edit`, for example), ArgoCD detects the drift and reverts it.
What "application delivery" means in this context:
It refers to the process of getting a containerised application running inside a Kubernetes cluster.
That includes:
- which container image to deploy
- how many replicas to run
- which environment variables to inject
- which ports to expose
- which resource limits to enforce

All of these are defined in YAML manifest files stored in Git.
ArgoCD reads those files and makes the cluster match them.

**Why this matters for the portfolio:**
- TerraDriftGuard already detects infrastructure drift in Terraform state.
- ArgoCD does the equivalent for Kubernetes workload state.
- The narrative connection is strong without any functional duplication:
    - one operates at the infrastructure layer
    - the other operates at the application layer.

**No canary or blue-green deployment here**
ArgoCD on its own does straightforward deployments: it replaces the old version with the new version.
Canary and blue-green strategies require an additional tool — Argo Rollouts — layered on top.

Adding Argo Rollouts would mean:
- a second complex tool to learn from scratch
- traffic-splitting configuration (requires a service mesh or ingress controller)
- meaningful testing of progressive rollback scenarios
- significantly more documentation

That pushes well beyond 1 week for someone new to Kubernetes.
The cleaner path is:
- to scope the project around ArgoCD and GitOps only
- to deliver it at the same production-grade standard as the existing 4 projects
- to leave progressive delivery as a potential follow-up project if the market demands it.

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

The portfolio narrative:
- ArgoCD watches 3 directories in a Git repository — one per environment.
    - A new container image version is promoted by updating the image tag in the dev manifest
    - then staging
    - then production.
- Every promotion is a Git commit.
- Every environment state is auditable.
- If the cluster drifts from what Git defines, ArgoCD corrects it automatically.

Proposed project name: GitOpsPromoter
The story it tells: 
"infrastructure is provisioned by Terraform, workloads are delivered by Git, and nothing runs that is not defined in code."
That message directly complements the existing portfolio without overlapping any of the 4 projects.

The README and any supporting documentation will include the rationale for choosing GitOps over progressive delivery.
It will explicitly state that this is a first Kubernetes project and that scope discipline matters more than feature density.



## 1. Creating the 'TerraKubePromoter' repository on GitHub
**Creating a git repository out of the local repository**
From the local project root `TerraKubePromoter`:
```bash
git init
git add .
git commit -m "Initial commit: .gitignore"
gh repo create TerraKubePromoter --public --description "EKS provisioned via Terraform, workloads delivered via ArgoCD GitOps" --source . --push
```
