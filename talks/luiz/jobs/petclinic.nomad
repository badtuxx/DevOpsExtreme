job "petclinic" {
  datacenters = ["dc1"]
  type        = "service"

  group "petclinic" {
    count = 2

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "petclinic"
      port = "http"

      tags = [
        "traefik.enable=true",
        "traefik.http.routers.http.rule=Host(`petclinic.feijuca.fun`)",
      ]

      check {
        type     = "http"
        port     = "http"
        path     = "/"
        interval = "5s"
        timeout  = "2s"
      }
    }

    task "petclinic" {
      driver = "docker"

      config {
        image = "laoqui/spring-petclinic:v1.0"
        ports = ["http"]
      }

      template {
        data        = <<EOF
SPRING_PROFILES_ACTIVE=mysql

SPRING_DATASOURCE_USERNAME=petclinic
SPRING_DATASOURCE_PASSWORD=petclinic

{{ with service "mysql" }}
{{ with index . 0 }}
SPRING_DATASOURCE_URL=jdbc:mysql://{{ .Address }}:{{ .Port }}/petclinic
{{ end }}{{ end }}
EOF
        destination = "secrets/env"
        env         = true
      }

      resources {
        cpu    = 300
        memory = 512
      }
    }
  }
}
