**Get the repository structure as a tree**
From the parent folder of the project folder:
```bash
tree -I '.git' TerraKubePromoter
```

The problem with that command is that it mixes files and directories in alphabetical order.
Better is to sort directories first, thus following the established convention:
```bash
tree -a --dirsfirst -I '.git|.idea|.terraform|*.tfstate|*.tfstate.backup|terraform.tfvars|tfplan|*.tfplan|journal.md|.venv|.pytest_cache|__pycache__' TerraKubePromoter
```

This also excludes the contents of '.git' and '.idea' directories.
`-I`: ignore
`.git|.idea`: exclude any file or directory whose name matches `.git` or `.idea`.
    The pipe `|` separates multiple patterns.


├── .github
│   └── workflows
│       ├── app-ci.yml
│       ├── manifests-ci.yml
│       ├── promote.yml
│       └── terraform-ci.yml
├── app
│   ├── src
│   │   ├── main.egg-info
│   │   │   ├── PKG-INFO
│   │   │   ├── SOURCES.txt
│   │   │   ├── dependency_links.txt
│   │   │   └── top_level.txt
│   │   ├── --init--.py
│   │   └── main.py
│   ├── tests
│   │   ├── __init__.py
│   │   └── test_main.py
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── VERSION
│   ├── docker-bake.hcl
│   ├── pyproject.toml
│   ├── requirements-dev.txt
│   └── requirements.txt
├── argocd
│   ├── applications
│   │   ├── terrakubepromoter-dev.yaml
│   │   ├── terrakubepromoter-production.yaml
│   │   └── terrakubepromoter-staging.yaml
│   ├── bootstrap
│   │   └── root-application.yaml
│   ├── projects
│   │   └── terrakubepromoter.yaml
│   ├── main.tf
│   ├── outputs.tf
│   ├── values.yaml
│   └── variables.tf
├── docs
│   ├── ADR
│   │   ├── 0001-select-gitops-with-argocd.md
│   │   ├── 0002-exclude-argo-rollouts-from-scope.md
│   │   └── 0003-use-lightweight-flask-workload.md
│   ├── images
│   │   ├── Billing&CostManagement_DataExports_27april2026-10h59.png
│   │   ├── Cost&UsageReport_April2026.png
│   │   ├── TagEditor_query1_27april2026-10h12.png
│   │   ├── TagEditor_query2_27april2026-10h23.png
│   │   └── UserDefinedCostAllocationTags_27april2026-10h34.png
│   └── repository_structure.md
├── manifests
│   ├── base
│   │   ├── deployment.yaml
│   │   ├── kustomization.yaml
│   │   ├── role.yaml
│   │   ├── rolebinding.yaml
│   │   ├── service.yaml
│   │   └── serviceaccount.yaml
│   ├── components
│   │   └── networkpolicy
│   │       ├── kustomization.yaml
│   │       └── networkpolicy.yaml
│   └── overlays
│       ├── dev
│       │   ├── kustomization.yaml
│       │   ├── namespace.yaml
│       │   └── resourcequota.yaml
│       ├── production
│       │   ├── kustomization.yaml
│       │   ├── namespace.yaml
│       │   └── resourcequota.yaml
│       └── staging
│           ├── kustomization.yaml
│           ├── namespace.yaml
│           └── resourcequota.yaml
├── scripts
│   ├── configure-github-repo.sh
│   ├── resolve-action-shas.sh
│   ├── verify-oidc-roles.sh
│   └── verify-tagging.sh
├── terraform
│   ├── modules
│   │   ├── argocd
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── values.yaml
│   │   │   └── variables.tf
│   │   ├── backend
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── cicd_iam_roles
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecr
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── ecr_scanning
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── eks
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── eks_addons
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── endpoints
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam_policies
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── iam_roles
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── nat
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── oidc
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── variables.tf
│   │   │   └── versions.tf
│   │   ├── route_tables
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── security_groups
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── subnets
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── terraform.tfvars.example
│   ├── variables.tf
│   └── versions.tf
├── .gitignore
└── README.md

42 directories, 120 files

