**Get the repository structure as a tree**
From the parent folder of the project folder:
```bash
tree -I '.git' TerraKubePromoter
```

The problem with that command is that it mixes files and directories in alphabetical order.
Better is to sort directories first, thus following the established convention:
```bash
tree -a --dirsfirst -I '.git|.idea|.terraform|*.tfstate|*.tfstate.backup|terraform.tfvars|tfplan' TerraKubePromoter
```

This also excludes the contents of '.git' and '.idea' directories.
`-I`: ignore
`.git|.idea`: exclude any file or directory whose name matches `.git` or `.idea`.
    The pipe `|` separates multiple patterns.

malikhamdane-site
├── .github
│   └── workflows
│       └── deploy.yml
├── build
│   ├── css
│   │   ├── mentions-legales.css
│   │   └── style.css
│   ├── de
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── en
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── es
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── fr
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── pt
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── ru
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── 404.html
│   └── index.html
├── docs
│   └── repository_structure.md
├── scripts
│   └── build.py
├── site
│   ├── css
│   │   ├── mentions-legales.css
│   │   └── style.css
│   ├── de
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── en
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── es
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── fr
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── includes
│   │   ├── footer.html
│   │   └── header.html
│   ├── pt
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── ru
│   │   ├── mentions-legales
│   │   │   └── index.html
│   │   └── index.html
│   ├── 404.html
│   └── index.html
├── terraform
│   ├── modules
│   │   ├── acm
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── cicd
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── cloudfront
│   │   │   ├── functions
│   │   │   │   └── language_redirect.js
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── route53
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── s3
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── zoho
│   │   ├── dkim.json
│   │   ├── mx.json
│   │   ├── txt-root.json
│   │   └── zoho-verification.json
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── variables.tf
├── .env
├── .env.example
├── .gitignore
├── CHANGELOG.md
├── README.md
└── journal.md

43 directories, 68 files
