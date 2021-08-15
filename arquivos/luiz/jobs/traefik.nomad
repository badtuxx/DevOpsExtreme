job "traefik" {
  datacenters = ["dc1"]
  type        = "system"

  group "traefik" {
    network {
      port "http" {
        static = 80
      }
    }

    service {
      name = "traefik"

      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "traefik" {
      driver = "docker"

      config {
        image        = "traefik:v2.4"
        network_mode = "host"

        ports = ["http"]

        volumes = [
          "local/config:/etc/traefik",
        ]
      }

      template {
        data        = <<EOF
[entryPoints]
  [entryPoints.http]
    address = ":80"

[accessLog]

[ping]
  entryPoint = "http"

[providers.file]
  directory = "/etc/traefik"

[api]
  dashboard = true
  insecure  = true

[providers.consulCatalog]
  prefix           = "traefik"
  exposedByDefault = false

  [providers.consulCatalog.endpoint]
    address = "127.0.0.1:8500"
    scheme  = "http"
EOF
        destination = "local/config/traefik.toml"
      }

      template {
        data        = <<EOF
[http.routers]
  [http.routers.traefik]
    entryPoints = ["http"]
    rule = "Host(`traefik.feijuca.fun`)"
    service = "api@internal"

  [http.routers.countdash]
    entryPoints = ["http"]
    rule = "Host(`countdash.feijuca.fun`)"
    service = "countdash"

{{ with service "ingress-gateway" }}
[http.services]
  [http.services.countdash.loadBalancer]
{{ range . }}
    [[http.services.countdash.loadBalancer.servers]]
      url = "http://{{ .Address }}:{{ .Port }}/"
{{ end }}
{{ else }}{{ end }}
EOF
        destination = "local/config/provider.toml"
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
