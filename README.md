# CST8918 - DevOps: Infrastructure as Code  
# CST8918 Hybrid Activity 06 - TFLint

**Student:** Khalid Amchat  

**Term:** Spring 2026  

## 1. Objective

The purpose of this activity was to add TFLint to an existing Terraform project. TFLint performs static analysis on Terraform code and helps detect configuration errors, missing declarations, and violations of recommended Infrastructure as Code practices.

The activity required the following tasks:

- Create a Git branch named `tflint`.
- Install and configure TFLint.
- Add the AzureRM TFLint plugin.
- Correct all issues reported by TFLint.
- Confirm that the existing Terratest tests still pass.
- Commit and push the completed work to GitHub.

## 2. Development Environment

The activity was completed using:

- WSL Ubuntu
- Visual Studio Code
- Terraform
- TFLint
- Azure CLI
- Go and Terratest
- Git and GitHub
- Microsoft Azure

## 3. Repository and Branch Setup

The activity repository was cloned locally, and a new branch named `tflint` was created.

```bash
git switch -c tflint
git branch
```

## 4. Terraform Initialization

Terraform was initialized in the root project directory to download the required providers.

```bash
terraform init
terraform fmt -recursive
terraform validate
```

This ensured that the Terraform configuration was formatted and valid before running TFLint.

## 5. TFLint Installation

TFLint was installed in WSL using the Linux installation script.

```bash
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | sudo bash
```


## 6. TFLint Configuration

A `.tflint.hcl` file was created in the root of the project.

```hcl
plugin "terraform" {
  enabled = true
  preset  = "all"
}

plugin "azurerm" {
  enabled = true
  version = "0.25.1"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}
```

The `all` preset enabled stricter Terraform checks than the default `recommended` preset. The AzureRM plugin added Azure-specific linting rules.

The required plugins were installed with:

```bash
tflint --init
```

## 7. Correcting TFLint Issues

TFLint was executed from the project root:

```bash
tflint
```

The original Terraform configuration contained issues detected by the stricter ruleset. One expected issue was that the `region` variable did not declare a type.

<img width="1202" height="342" alt="Screenshot 2026-07-08 181657" src="https://github.com/user-attachments/assets/5ec76039-f214-4216-83cb-f890b957a877" />

The variable was corrected by adding `type = string`.

```hcl
variable "region" {
  type    = string
  default = "canadacentral"
}
```

Other reported issues were corrected based on the TFLint output. These included adding missing variable or output descriptions.

<img width="1226" height="1012" alt="Screenshot 2026-07-10 123503" src="https://github.com/user-attachments/assets/f7cd64b0-8734-4089-a1d7-09480b7cd554" />

After correction, the following commands were used:

```bash
terraform fmt -recursive
terraform validate
tflint
```

The process was repeated until TFLint reported no remaining issues.

## 8. Terratest Configuration

The Terratest file was updated with the correct Azure subscription ID and student label prefix.

## 9. Running Terratest

The tests were run from the `test` directory.

```bash
go test -v azure_webserver_test.go
```

Terratest initialized Terraform, deployed the Azure resources, checked the required conditions, and destroyed the resources after the test.

> **Screenshot:** successful Terratest result.
<img width="1280" height="197" alt="Screenshot 2026-07-10 145228" src="https://github.com/user-attachments/assets/b6cd91da-24b9-423d-aa20-94c3055d4fa5" />

## 10. Conclusion

This activity demonstrated how TFLint can improve Terraform code quality by identifying problems before infrastructure is deployed. The strict `all` preset provided additional checks, while the AzureRM plugin validated Azure-related configuration. Terraform validation, TFLint, and Terratest together provided multiple levels of verification for the Infrastructure as Code project.
