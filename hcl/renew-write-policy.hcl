path "secret/*" {
  policy = "write"
}

path "secret/foo" {
  policy = "deny"
}

path "auth/token/create" {
 policy = "sudo"
}

path "/auth/token/renew-self" {
 policy = "sudo"
}
path "/auth/token/renew/*" {
 policy = "sudo"
}
