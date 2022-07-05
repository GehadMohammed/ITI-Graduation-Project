resource "kubernetes_service" "jenkins-svc" {
  metadata {
    name      = "jenkins-svc"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  spec {
    selector = {
      name = "jenkins"
    }
    type = "NodePort"
    port {
      node_port   = 30080
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_service" "nexus-svc" {
  metadata {
    name      = "nexus-svc"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  spec {
    selector = {
      name = "nexus"
    }
    type = "NodePort"
    port {
      node_port   = 30081
      port        = 8081
      target_port = 8081
    }
  }
}