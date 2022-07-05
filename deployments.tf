resource "kubernetes_deployment" "Jenkins" {
  metadata {
    name = "jenkins-deployment"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  
  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "jenkins"
        tier = "base"
      }
    }
    template {
      metadata {
        labels =  {
          name = "jenkins"
          tier = "base"
        }
      }
      spec {
        container {
          name = "jenkins-master"
          image  = "nouranhamdy1998/jenkins-master:v1"
          port {
            container_port = 8080
          }
          security_context {
            run_as_group = 1000
            run_as_user = 0
          }
          volume_mount {
            mount_path = "/var/run/docker.sock"
            name = "docker-sock-volume"
          }
          volume_mount {
            mount_path = "/var/jenkins_home"
            name = "jenkins-data"
          }
        }
        volume {
          name = "docker-sock-volume"
          host_path {
            path = "/var/run/docker.sock"
          }
        }
        volume {
          name = "jenkins-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.jenkins-pvc.metadata.0.name
          }
        }
      }
    }
  }
}


resource "kubernetes_deployment" "Nexus" {
  metadata {
    name = "nexus-deployment"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  
  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "nexus"
        tier = "base"
      }
    }
    template {
      metadata {
        labels = {
          name = "nexus"
          tier = "base"
        }
      }
      spec {
        container {
          resources {
            limits = {
              memory = "4Gi"
              cpu = "1000m"
            }
            requests = {
              memory = "2Gi"
              cpu = "500m"
            }
          }
          image = "sonatype/nexus3:latest"
          name  = "nexus"
          port {
            container_port = 8081
          }
          security_context {
            run_as_group = 1000
            run_as_user = 0
          }
          volume_mount {
            mount_path = "/nexus-data"
            name = "nexus-data"
          }    
        }
        volume {
          name = "nexus-data"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.nexus-pvc.metadata.0.name
          }
        }
      }
    }
  }
}
