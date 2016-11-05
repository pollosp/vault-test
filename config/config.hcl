backend "file" {
  path = "/file"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

disable_cache = true
disable_mlock = true
max_lease_ttl = "10h"
default_lease_ttl = "10h"
cluster_name = "testcluster"
