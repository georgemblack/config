# Common Commands & Config for Vault

## Vault Agent

Example Vault Agent config for AWS auth:

```
pid_file = "./pidfile"

vault {
  address = "https://vault.gringotts.net"
}

auto_auth {
  method {
    type = "aws"

    config = {
      type = "iam"
      role = "gringotts-role"
    }
  }

  sink {
    type = "file"

    config = {
      path = "/home/ec2-user/vault-token"
    }
  }
}

template {
  source      = "/home/ec2-user/template.ctmpl"
  destination = "/home/ec2-user/secrets.txt"
}
```

Example template:

```
{{ with secret "kv/data/some-path" }}
My Secret: {{ .Data.data.my-secret }}
{{ end }}
```

## Vault Server

Example Vault config:

```
storage "raft" {
  path    = "/home/ec2-user/db/data"
  node_id = "gringotts-node-x"
}

listener "tcp" {
  address     = "0.0.0.0:443"
  tls_disable = "true"
}

api_addr = "https://vault.gringotts.net"
cluster_addr = "http://vault-node-x.gringotts.net:8201"
ui = true
```

Example service config:

```
Description=Gringotts Vault

Wants=network.target
After=syslog.target network-online.target

[Service]
Type=simple
ExecStart=/home/ec2-user/vault server --config=/home/ec2-user/config.hcl
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
```

Commands to run/view service:

```
sudo vim /etc/systemd/system/Gringotts.service
sudo systemctl daemon-reload
sudo systemctl enable Gringotts
sudo systemctl start Gringotts
systemctl status Gringotts
journalctl -u Gringotts.service
```

## Vault CLI

Enable AWS auth:

```
vault auth enable aws
vault auth list
```

Create role that can authenticate with Vault:

```
vault write auth/aws/role/my-role \
   auth_type=iam \
   bound_iam_principal_arn="${AWS_ROLE_ARN}" \
   policies=some-policy

vault list auth/aws/role
```

