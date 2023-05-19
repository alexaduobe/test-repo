# Terraform Build Tools packaged Daugherty Business Solutions

## Overview

Provides all of the tools needed by a typical Terraform module CI/CD pipeline.
Daugherty uses Bitbucket Pipelines but it should work with other CI/CD systems.

List of installed tools:

* `go` - Useful for running Terratest-based tests.
* `terraform-switcher` (alias tfswtich) - Downloads required Terraform version if not cached as sets in path.
* `terraform-docs` - Generates Terraform module documentation from source code.
* `tflint` - Validates source files conform to standards.
* `conftest` - Validates Terraform-created resources conform to OPA-defined rules.
* `pre-commit` - Executes git hooks defined in `.pre-commit-config.yaml`
* `checkov` - Checks for security issues.

## License

This image is built from the `bitnami/golang` image. That image is Copyright $copy; 2022 Bitnami
under the Apache License, Version 2.0.

This image is:

Copyright &copy; 2022 Daugherty

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
except in compliance with the License. You may obtain a copy of the License at

`http://www.apache.org/licenses/LICENSE-2.0`

Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY 
KIND, either express or implied. See the License for the specific language governing 
permissions and limitations under the License.
