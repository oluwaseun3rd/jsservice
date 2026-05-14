variable "kube_context" {
  description = "Kubeconfig context to use."
  type        = string
  default     = "minikube"
}

variable "environment" {
  description = "Value injected as ENV in the secret."
  type        = string
  default     = "dev"
}