# Ansible

1. Configure HashiCorp Vault access

```shell
export VAULT_ADDR="https://vault.horna.local"
export VAULT_SKIP_VERIFY=true
```

2. Login to vault using GitHub token

```shell
vault login -method=github token=$(gh auth token)
```

3. Get Private Key from Vault

```shell
vault kv get -field=id_rsa Infrastructure-Access/proxmox > id_rsa
chmod 600 ./id_rsa
```

4. Run Ansible playbook to provision k3s cluster

```shell
ansible-playbook k3s.orchestration.site -i ./inventory.yml --private-key ./id_rsa
```

5. Run Ansible playbook to add local docker registry as trusted
```shell
ansible-playbook -i ./inventory.yml --private-key ./id_rsa \
    ./playbooks/add-local-docker-registry-to-trusted.yaml \
    --extra-vars "vault_approle_role_id=your-role-id vault_approle_secret_id=your-secret-id"
```


5. Remove `id_rsa` file
```shell
rm -f ./id_rsa
```