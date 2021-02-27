terraform {
  required_providers {
    docker = {
      source  = "terraform-providers/docker"
      version = "~> 2.7.2"
    }
  }
}


provider "docker" {}

resource "docker_image" "nodered" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-",["nodred_container",random_string.random[count.index].result])
  image = docker_image.nodered.latest
  ports {
    internal = 1880
    external = 1880
  }
}


resource "random_string" "random" {
  count = 2
  length           = 4
  special          = true
  override_special = "/@£$"
}

output "ip" {
  value =[for i in docker_container.nodered_container[*]: join(":",[i.name])]
}