require 'vault'
Vault.address = 'http://127.0.0.1:8200' # Also reads from ENV["VAULT_ADDR"]
Vault.token   = 'e22577cd-c7d2-0592-7c59-ddc0b3c4a3e4' # Also reads from ENV["VAULT_TOKEN"]
#p Vault.auth_token.create(
#    policies: ['foo'],
#      wrap_ttl: 500,
#)

#p Vault.logical.read('secret/ardilla')

# Unwrap wrapped response for final token using the initial temporary token.
p Vault.auth_token.renew('e22577cd-c7d2-0592-7c59-ddc0b3c4a3e4')
