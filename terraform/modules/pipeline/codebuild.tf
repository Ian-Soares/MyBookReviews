data "template_file" "buildspec" {
  template = file("${path.module}/templates/buildspec.yml")

  vars = {
    repository_url = "${var.repository_url}"
    region         = "${var.region}"
    cluster_name   = "${var.cluster_name}"
    container_name = "${var.container_name}"

    security_group_ids = "${join(",", var.subnet_ids)}"
  }
}

resource "aws_codebuild_project" "app_build" {
  name          = "${var.cluster_name}-codebuild"
  build_timeout = "60"

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_ACCESS_KEY_ID"
      value = var.AWS_ACCESS_KEY_ID
    }

    environment_variable {
      name  = "AWS_SECRET_ACCESS_KEY"
      value = var.AWS_SECRET_ACCESS_KEY
    }

    environment_variable {
      name  = "AWS_SESSION_TOKEN"
      value = var.AWS_SESSION_TOKEN
    }

    environment_variable {
      name  = "EKS_CLUSTER_NAME"
      value = var.cluster_name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.template_file.buildspec.rendered
  }
}
