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
