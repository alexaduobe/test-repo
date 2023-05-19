resource "aws_ecrpublic_repository" "terraform_dbsbuild" {
  repository_name = "terraform-dbsbuilder"
  catalog_data {
    about_text        = file("templates/terraform-dbsbuilder-about.md")
    architectures     = ["x86-64"]
    description       = "Bundles tools needed by CI/CD pipelines like Bitbucket for building, testing and deploying Terraform modules."
    logo_image_blob   = filebase64("images/daughertystacked_trans3.png")
    operating_systems = ["Linux"]
    usage_text        = file("templates/terraform-dbsbuilder-usage.md")
  }
}
