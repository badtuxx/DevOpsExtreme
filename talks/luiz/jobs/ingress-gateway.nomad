job "ingress-gateway" {
  datacenters = ["dc1"]
  type        = "service"

  group "ingress-gateway" {
    network {
      mode = "bridge"

      port "countdash" {
        to = 9002
      }
    }

    service {
      name = "ingress-gateway"
      port = "countdash"

      connect {
        gateway {
          proxy {}

          ingress {
            listener {
              port     = 9002
              protocol = "tcp"

              service {
                name = "count-dashboard"
              }
            }
          }
        }
      }
    }
  }
}
