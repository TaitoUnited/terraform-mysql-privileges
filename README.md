# MySQL privileges

Terraform module for managing MySQL cluster privileges. Example usage with two MySQL clusters:

```
locals {
  databases = yamldecode(file("${path.root}/../databases.yaml"))
}

provider "mysql" {
  alias           = "mysql1"
  endpoint        = "$(databases["mysql1"].host}:${databases["mysql1"].port}"
  username        = databases["mysql1"].adminUsername
  password        = var.mysql1_password
}

provider "mysql" {
  alias           = "mysql2"
  endpoint        = "$(databases["mysql2"].host}:${databases["mysql2"].port}"
  username        = databases["mysql2"].adminUsername
  password        = var.mysql2_password
}

module "mysql1_privileges" {
  source                     = "TaitoUnited/privileges/mysql"
  version                    = "1.0.0"
  providers = {
    mysql = mysql.mysql1
  }

  privileges                 = databases["mysql1"]
}

module "mysql2_privileges" {
  source                     = "TaitoUnited/privileges/mysql"
  version                    = "1.0.0"
  providers = {
    mysql = mysql.mysql2
  }

  privileges                 = databases["mysql2"]
}
```

Example databases.yaml:

```
mysql1:
  host: 127.127.127.127
  port: 5432
  adminUsername: mysql

  # privileges
  roles:
    - name: my_project_admin
      permissions:
        - database: my_project_database
          privileges: ["ALL"]
        - database: my_project_database
          privileges: ["ALL"]
    - name: my_project_support
      permissions:
        - database: my_project_database
          privileges: ["SELECT", "UPDATE"]
  users:
    - name: john_doe
      permissions:
        - database: another_database
          privileges: ["SELECT"]
        - database: some_database
          roles: [ "my_project_support" ]

mysql2:
  host: 127.127.127.127
  port: 5432
  adminUsername: mysql

  # privileges
  users:
    - name: john_doe
      permissions:
        - database: some_database
          privileges: ["SELECT"]
```

TIP: This module is used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/).

Contributions are welcome!
