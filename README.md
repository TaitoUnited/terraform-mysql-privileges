# MySQL permissions

Terraform module for managing MySQL cluster permissions. Example usage with two MySQL clusters:

```
locals {
  databases = yamldecode(file("${path.root}/../databases.yaml"))
}

provider "mysql" {
  alias           = "mysql1"
  host            = databases["mysql1"].host
  port            = databases["mysql1"].port
  username        = databases["mysql1"].adminUsername
  password        = var.mysql1_password
}

provider "mysql" {
  alias           = "mysql2"
  host            = databases["mysql2"].host
  port            = databases["mysql2"].port
  username        = databases["mysql2"].adminUsername
  password        = var.mysql2_password
}

module "mysql1_permissions" {
  source                     = "TaitoUnited/permissions/mysql"
  version                    = "1.0.0"
  provider                   = "mysql.mysql1"
  permissions                = databases["mysql1"]
}

module "mysql2_permissions" {
  source                     = "TaitoUnited/permissions/mysql"
  version                    = "1.0.0"
  provider                   = "mysql.mysql2"
  permissions                = databases["mysql2"]
}
```

Example databases.yaml:

```
mysql1:
  host: 127.127.127.127
  port: 5432
  adminUsername: mysql

  # Permissions
  roles:
    - name: my_project_admin
      permissions:
        - database: my_project_database
          type: table
          privileges: ["ALL"]
        - database: my_project_database
          type: sequence
          privileges: ["ALL"]
    - name: my_project_support
      permissions:
        - database: my_project_database
          type: table
          privileges: ["SELECT", "UPDATE"]
  users:
    - name: john.doe
      roles: [ "my_project_support" ]
      permissions:
        - database: another_database
          type: table
          privileges: ["SELECT"]

mysql2:
  host: 127.127.127.127
  port: 5432
  adminUsername: mysql

  # Permissions
  users:
    - name: john.doe
      permissions:
        - database: some_database
          type: table
          privileges: ["SELECT"]
```

TIP: This module is used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/).

Contributions are welcome!
