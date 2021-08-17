job "mysql-setup" {
  datacenters = ["dc1"]
  type        = "batch"

  group "petclinic" {
    task "setup" {
      driver = "docker"

      config {
        image   = "mysql:5.7"
        command = "/bin/bash"
        args    = ["local/script.sh"]
      }

      artifact {
        source      = "https://raw.githubusercontent.com/spring-projects/spring-petclinic/main/src/main/resources/db/mysql/user.sql"
        destination = "local"
      }

      artifact {
        source      = "https://raw.githubusercontent.com/spring-projects/spring-petclinic/main/src/main/resources/db/mysql/schema.sql"
        destination = "local"
      }

      artifact {
        source      = "https://raw.githubusercontent.com/spring-projects/spring-petclinic/main/src/main/resources/db/mysql/data.sql"
        destination = "local"
      }

      template {
        data        = <<EOF
[client]
host=mysql.service.consul
port=3306
user=root
password=root
EOF
        destination = "secrets/.my.cnf"
      }

      template {
        data        = <<EOF
#!/usr/bin/env bash

echo "Creating database..."
mysql --defaults-file=secrets/.my.cnf < local/user.sql

echo "Loading SQL schema..."
mysql --defaults-file=secrets/.my.cnf petclinic < local/schema.sql

echo "Loading SQL data..."
mysql --defaults-file=secrets/.my.cnf petclinic < local/data.sql

echo "Done"
EOF
        destination = "local/script.sh"
      }
    }
  }
}
