**Get the repository structure as a tree**
From the parent folder of the project folder:
```bash
tree -I '.git' TerraKubePromoter
```

The problem with that command is that it mixes files and directories in alphabetical order.
Better is to sort directories first, thus following the established convention:
```bash
tree -a --dirsfirst -I '.git|.idea|.terraform|*.tfstate|*.tfstate.backup|terraform.tfvars|tfplan|journal.md' TerraKubePromoter
```

This also excludes the contents of '.git' and '.idea' directories.
`-I`: ignore
`.git|.idea`: exclude any file or directory whose name matches `.git` or `.idea`.
    The pipe `|` separates multiple patterns.

TerraKubePromoter
├── .github
│   └── workflows
├── app
├── docs
│   ├── ADR
│   │   ├── 0001-select-gitops-with-argocd.md
│   │   ├── 0002-exclude-argo-rollouts-from-scope.md
│   │   └── 0003-use-lightweight-flask-workload.md
│   └── repository_structure.md
├── manifests
│   ├── dev
│   ├── production
│   └── staging
├── terraform
├── .gitignore
└── README.md

11 directories, 6 files
