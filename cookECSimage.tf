terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  //host = "unix:///var/run/docker.sock"
  //host = "/var/run/docker.sock"
  registry_auth {
      address = data.aws_ecr_authorization_token.token.proxy_endpoint
      username = data.aws_ecr_authorization_token.token.user_name
      password  = data.aws_ecr_authorization_token.token.password
    }
}

resource "aws_ecr_repository" "webserver" {
  name                 = "image"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

# get authorization credentials to push to ecr
data "aws_ecr_authorization_token" "token" {}

resource "docker_image" "webserver" {
  
  name = "${aws_ecr_repository.webserver.repository_url}:latest"
  build {
    context = "."
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "html/*") : filesha1(f)]))
  }
}

resource "docker_registry_image" "media-handler" {
  name = docker_image.webserver.name
  keep_remotely = true
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "html/*") : filesha1(f)]))
  }
}

