



module "image" {
  source = "./image"
  image_in =var.image["dev"]
  
}
resource "null_resource" "dockervol" {
  provisioner "local-exec" {
  command = "mkdir nodredvol/ || true && sudo chown -R 1000:1000 nodredvol/"
  }
}

locals {

    container_count =length(lookup(var.ext_port,var.env))
}
module "container" {
  source = "./container"
  depends_on = [ null_resource.dockervol ]
  count = local.container_count
  name_in  = join("-",["Hello2",null_resource.dockervol.id,random_string.random[count.index].id])
  image_in = module.image.image_out
  internal_in = 1880
  external_in = lookup(var.ext_port,var.env)[count.index]
  container_path_in="/data"
  host_path_in="${path.cwd}/noderedvol"
  
}

resource "random_string" "random" {
  count            = 2
  length           = 4
  special          = true
  override_special = "/@£$"
}

