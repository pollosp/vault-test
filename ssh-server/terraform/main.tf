# terraform plan -var "ssh_fingerprint=$SSH_FINGERPRINT"
# ssh-keygen -lf ~/.ssh/id_rsa-do.pub
variable "ssh_fingerprint" {}

provider "digitalocean" {
  # You need to set this in your .bashrc
  # export DIGITALOCEAN_TOKEN="Your API TOKEN"
  #
}

resource "digitalocean_droplet" "ssh-test" {
# Bearer is mandatory
# $TOKEN is env var
# curl -X GET -H "Content-Type: application/json"  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/account/keys"
# Look for the finger print and key ID in the JSON
  ssh_keys = ["${var.ssh_fingerprint}"]
  image              = "ubuntu-14-04-x64"
  region             = "nyc2"
  size               = "512mb"
  private_networking = true
  backups            = true
  ipv6               = true
  name               = "ssh-tests-vault"

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
    ]

    connection {
      type     = "ssh"
      private_key = "${file("~/.ssh/id_rsa-do")}"
      user     = "root"
      timeout  = "2m"
    }
  }
}
