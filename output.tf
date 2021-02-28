# output "ip" {
#   value = [for i in docker_container.nodered_container[*] : join(":", [i.name])]
# }

# output "test" {
#   value = local.test_var
# }

output "container_name" {
  value = module.container[*].container_name
}