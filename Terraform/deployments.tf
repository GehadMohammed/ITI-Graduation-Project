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
          service_account_name = kubernetes_service_account_v1.jenkins_sa.metadata.0.name
        container {
          name = "jenkins-master"
          image  = "amr158/jenkins-master"
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
          volume_mount {
            mount_path = "/nexus-data"
            name = "nexus-data"
          }    
        }
        volume {
          name = "nexus-data"
          empty_dir {
            
          }
        }
      }
    }
  }
}
