# Daugherty Labs AWS Infrastructure

Contains the infrastructure-as-code which provisions and maintains the
Daugherty Labs AWS multi-account base infrastructure.

## Repository Layout

Repository follows a monorepo approach with various deployment tasks executed from a specific directory.

Directory groups are:

* `sites` - Simple static or mostly static websites used to delineate boundaries and provide health checks.
* `serverless` - AWS Lambdas application code for automated AWS infrastructure management and auditing with a directory per Lambda.
* `terraform/modules` - Simple Terraform modules unlikely to ever be used outside the context of this organization.
* `terraform/stacks` - Top-level Terraform definitions which will be executed by CI/CD pipelines to create AWS resources.

Directory structure:

> `basedir`
>
> * `cloudformation`
>     * `stacks`
>         * `<deployment-stack-name>`
> * `sites`
>     * `<local-site-name>`
> * `serverless`
>     * `<local-function-name>`
> * `terraform`
>     * `modules`
>         * `<local-module-name>`
>     * `stacks`
>         * `<deployment-stack-name>`

## Terraform Stacks Overview

See the README in each stack for more details.
