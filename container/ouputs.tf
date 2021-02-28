output "container_name" {
  value= flatten(docker_container.nodered_container[*].name)
}