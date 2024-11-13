variable "sg_name" {
  description = "Nom du security group"
  type        = string
  default     = "emr-security-group"
}

variable "sg_description" {
  description = "Description du security group"
  type        = string
  default     = "Security group for EMR cluster"
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "ingress_rules" {
  description = "Liste des règles d'entrée"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string))
    self        = optional(bool)
  }))
  default = []
}

variable "additional_tags" {
  description = "Tags additionnels à ajouter au security group"
  type        = map(string)
  default     = {}
}

output "security_group_id" {
  description = "ID du security group"
  value       = aws_security_group.emr_sg.id
}

output "security_group_name" {
  description = "Nom du security group"
  value       = aws_security_group.emr_sg.name
}