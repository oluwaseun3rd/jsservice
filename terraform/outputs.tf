output "namespace_name" {
  description = "The name of the created namespace"
  value       = kubernetes_namespace.apps.metadata[0].name
}

output "secret_name" {
  description = "The name of the created secret"
  value       = kubernetes_secret.app_config.metadata[0].name
}

output "secret_namespace" {
  description = "Namespace the secret was created in"
  value       = kubernetes_secret.app_config.metadata[0].namespace
}