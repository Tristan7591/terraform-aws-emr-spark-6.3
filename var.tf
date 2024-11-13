variable "region"{
    type = string
    description = "AWS region"
    default     = "eu-west-3"
}
variable "instance_type" {
    description = "Type d'instance EC2 pour les noeuds master et core"
    type        = string
    default     = "t3.micro"
}

variable "instance_count" {
    description = "Nombre d'instances dans le cluster"
    type        = number
    default     = 1
}

variable "cluster_name" {
    description = "Nom du cluster EMR"
    type        = string
    default     = "spark-cluster"
}

variable "release_label" {
    description = "Version d'EMR à utiliser"
    type        = string
    default     = "emr-6.3.0"  //////tcheck la version il la faut la 3 pour du spark only
}

variable "ebs_size" {
    description = "Taille des volumes EBS en GB"
    type        = number
    default     = 20
}

variable "ebs_type" {
    description = "Type de volume EBS"
    type        = string
    default     = "gp2"
}

variable "ebs_volumes_per_instance" {
    description = "Nombre de volumes EBS par instance"
    type        = number
    default     = 1
}

variable "ebs_root_volume_size" {
    description = "Taille du volume root EBS en GB"
    type        = number
    default     = 20
}