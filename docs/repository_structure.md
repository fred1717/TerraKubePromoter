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

TerraKubePromoter
├── .github
│   └── workflows
├── app
│   ├── src
│   │   ├── --init--.py
│   │   └── main.py
│   ├── tests
│   │   ├── --init--.py
│   │   └── test_main.py
│   ├── .dockerignore
│   ├── Dockerfile
│   ├── docker-bake.hcl
│   ├── pyproject.toml
│   ├── requirements-dev.txt
│   └── requirements.txt
├── docs
│   ├── ADR
│   │   ├── 0001-select-gitops-with-argocd.md
│   │   ├── 0002-exclude-argo-rollouts-from-scope.md
│   │   └── 0003-use-lightweight-flask-workload.md
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
├── terraform
│   ├── modules
│   │   ├── backend
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

26 directories, 64 files






