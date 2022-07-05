# resource "kubernetes_persistent_volume" "jenkins-pv" {
#   metadata {
#     name = "jenkins-data-pv"
#   }
#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name = "manual"
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_source {
#         host_path {
#           path = "/home/amr/Downloads/ITI-GP/Terraform/jenkins-data"
#         }
#     }
#   }
# }

# resource "kubernetes_persistent_volume" "nexus-pv" {
#   metadata {
#     name = "nexus-data-pv"
#   }
#   spec {
#     capacity = {
#       storage = "1Gi"
#     }
#     storage_class_name = "manual"
#     access_modes = ["ReadWriteMany"]
#     persistent_volume_source {
#         host_path {
#           path = "/home/amr/Downloads/ITI-GP/Terraform/jenkins-data"
#         }
#     }
#   }
# } 