job "mysql" {
  datacenters = ["dc1"]
  type        = "service"

  group "mysql" {
    network {
      port "mysql" {
        static = 3306
      }
    }

    service {
      name = "mysql"
      port = "mysql"

      check {
        type     = "tcp"
        port     = "mysql"
        interval = "10s"
        timeout  = "2s"
      }
    }

    volume "mysql" {
      type   = "host"
      source = "mysql"
    }

    task "mysql" {
      driver = "docker"

      config {
        image = "mysql:5.7"
        ports = ["mysql"]
      }

      env {
        MYSQL_ROOT_PASSWORD = "root"
        MYSQL_DATABASE      = "petclinic"
        MYSQL_USER          = "petclinic"
        MYSQL_PASSWORD      = "petclinic"
      }

      volume_mount {
        volume      = "mysql"
        destination = "/var/lib/mysql"
      }
    }
  }
}
