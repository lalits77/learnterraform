variable ext_port{
type = map 
//sensitive = true
# default =1880
validation {
  condition = max(var.ext_port["dev"]...) <=63300 && min(var.ext_port["dev"]...) >0 
  error_message = "The internal port must be 1881."
}
}

variable "container_count" {
  type =number
  default =3
}

variable "env" {
  type = string 
  default = "dev"
}

variable "image" {
  type =map
  description = "Image for nodered"
  default = {
     dev = "nodered/node-red:latest"
     prod = "nodered/node-red:latest-minimal"
  }
}