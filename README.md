#VAULT
Test vault

- `docker-compose create` It builds the container
- `docker-compose start` It starts the container
- `docker-compose exec vault vault init` It initzialize the vault with 5 keys, you need this in order unseal the vault and it is goint to return root token in order unseal the vault
- `docker-compose exec vault vault unseal`
- `docker-compose exec vault vault auth` Root token required for this test
- `docker-compose exec vault vault policy-write foo /hcl/foo-policy.hcl`
- `docker-compose exec vault vault policy-write secret /hcl/renew-write-policy.hcl`
- `docker-compose exec vault vault token-create -policy="secret"`
- `docker-compose exec vault vault token-create -policy="foo"`
- `docker-compose exec vault vault write secret/foo value=yes`
- `docker-compose exec vault vault write secret/ardilla value=password`
