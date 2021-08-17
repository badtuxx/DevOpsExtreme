job "example" {
  datacenters = ["dc1"]
  type        = "service"

  group "cache" {
    network {
      port "db" {
        to = 6379
      }
    }

    task "redis" {
      driver = "docker"

      config {
        image = "redis:4.0"
        ports = ["db"]
      }

      resources {
        cpu    = 100
        memory = 16
      }
    }

    task "ping" {
      driver = "docker"

      config {
        image   = "redis:4.0"
        command = "/bin/bash"
        args    = ["/local/script.sh"]
      }

      resources {
        cpu    = 100
        memory = 16
      }


      template {
        data        = <<EOF
#!/usr/bin/env bash

env | grep NOMAD

while true
do
  redis-cli -h ${NOMAD_HOST_IP_db} -p ${NOMAD_HOST_PORT_db} PING
  sleep 3
done
EOF
        destination = "local/script.sh"
      }
    }
  }
}
