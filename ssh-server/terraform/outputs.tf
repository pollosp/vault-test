output "Public ip" {
  value = "${digitalocean_droplet.ssh-test.ipv4_address}"
}
