resource "kubernetes_persistent_volume_claim" "jenkins-pvc" {
  metadata {
    name = "jenkins-data-pvc"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "manual"
    volume_name = kubernetes_persistent_volume.jenkins-pv.metadata.0.name
  }
}

resource "kubernetes_persistent_volume_claim" "nexus-pvc" {
  metadata {
    name = "nexus-data-pvc"
    namespace = kubernetes_namespace.tools.metadata.0.name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "manual"
    volume_name = kubernetes_persistent_volume.nexus-pv.metadata.0.name
  }
} 