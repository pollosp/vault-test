#VAULT
Test vault
## Password Tokens
- `docker network create vaulttest_default`
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

## MySQL
The MySQL secret backend for Vault generates database credentials dynamically based on configured roles. This means that services that need to access a database no longer need to hardcode credentials: they can request them from Vault, and use Vault's leasing mechanism to more easily roll keys.

### MYSQL BACKEND
- `docker-compose exec vault vault mount mysql`
- `docker-compose exec vault vault write mysql/config/connection connection_url="root:verysecret@tcp(mysql:3306)/"`
- `docker-compose exec vault vault write mysql/config/lease lease=1h lease_max=24h`
- This restricts each credential to being valid or leased for 1 hour at a time, with a maximum use period of 24 hours. This forces an application to renew their credentials at least hourly, and to recycle them once per day.

### CREATE MYSQL USERS
- `docker-compose exec vault vault write mysql/roles/readonly sql="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"`
- `docker-compose exec vault vault write mysql/roles/full sql="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT ALL ON *.* TO '{{name}}'@'%';"`
- `docker-compose exec vault vault read mysql/creds/readonly`
- `docker-compose exec mysql mysql -uread-root-6df374 -pa2332e92-d0be-fe5f-2be3-5e1b6a4a5fbd`
- `docker-compose exec vault vault renew mysql/creds/readonly/1712c7e8-3611-3bfe-aafa-14becf7ccc3e` #Renews the Lease-id

## SSH
For future tests
- https://www.vaultproject.io/docs/secrets/ssh/index.html
- https://github.com/hashicorp/vault-ssh-helper
- https://releases.hashicorp.com/vault-ssh-helper/
- https://github.com/sjourdan/vault-ssh-backend

