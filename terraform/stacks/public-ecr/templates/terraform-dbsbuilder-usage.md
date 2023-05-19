### Usage Examples

Bitbucket Pipeline

```yaml
image:
  name: public.ecr.aws/daugherty/terraform-dbsbuilder:0.1.0
  run-as-user: 1000

pipelines:
  default:
    - parallel:
        - step:
            name: Test
            script:
              - tfswitch
              - terraform --version
              - terraform fmt -check
              - pre-commit run --all-files
              - cd test
              - go test
```

### Dockerfile

```
FROM public.ecr.aws/bitnami/golang:1.17.6-debian-10-r7

# Create non-root user
RUN groupadd -g 1000 dbsbuilder && \
    useradd -g 1000 -u 1000 -d /home/dbsbuilder -s /bin/bash dbsbuilder && \
    mkdir -p /home/dbsbuilder/bin && \
    echo "export PATH=/home/dbsbuilder/bin:\$PATH" >> /home/dbsbuilder/.bash_profile && \
    chown -R dbsbuilder:dbsbuilder /home/dbsbuilder
# Add python
RUN apt-get update && \
    apt-get install -y python3 python3-pip libffi-dev && \
    pip3 install 'typing-extensions==3.7.4.3' && \
    pip3 install pre-commit checkov && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /go

# Install Terraform tools using go install with executables in /go/bin
RUN go install github.com/warrensbox/terraform-switcher@0.13.1201 && \
    ln -s /go/bin/terraform-switcher /go/bin/tfswitch
RUN go install github.com/terraform-docs/terraform-docs@v0.16.0
RUN go install github.com/terraform-linters/tflint@v0.34.1
RUN go install github.com/open-policy-agent/conftest@v0.30.0
# RUN go install github.com/gruntwork-io/terragrunt@v0.35.20

USER dbsbuilder
WORKDIR /home/dbsbuilder
```