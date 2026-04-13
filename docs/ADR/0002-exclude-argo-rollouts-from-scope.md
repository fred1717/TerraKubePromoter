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
