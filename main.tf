module "emr_security_group" {
  source = "./modules/sg"
  
  vpc_id         = data.aws_vpc.default.id
  sg_name        = "emr-security-group"
  sg_description = "Security group for EMR cluster"
  
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [data.aws_vpc.default.cidr_block]
    },
    {
      from_port = 8443
      to_port   = 8443
      protocol  = "tcp"
      self      = true
    },
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      self      = true
    }
  ]
  
  additional_tags = {
    Environment = "production"
    Project     = "EMR"
  }
}

resource "aws_emr_cluster" "cluster-spark" {
  name          = var.cluster_name
  release_label = var.release_label
  applications  = ["Spark"]

 #additional info a rajouter ici

  termination_protection            = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
  subnet_id                         = data.aws_subnet.default.id
  emr_managed_master_security_group = module.emr_security_group.security_group_id
  emr_managed_slave_security_group  = module.emr_security_group.security_group_id
  instance_profile                  = aws_iam_instance_profile.emr_profile.arn
  
  }

  master_instance_group {
    instance_type = var.instance_type
  }

  core_instance_group {
    instance_type  = var.instance_type
    instance_count = var.instance_count

    ebs_config {
      size                 = var.ebs_size
      type                 = var.ebs_type
      volumes_per_instance = var.ebs_volumes_per_instance
      
    }

  }

  ebs_root_volume_size = var.ebs_root_volume_size

  tags = {
    role = "Cluster-Spark"
    env  = "Production"
  }
  


  #Déclaration des vrariables d'environnement:
  
  configurations_json = <<EOF
  [
    {
      "Classification": "hadoop-env",
      "Configurations": [
        {
          "Classification": "export",
          "Properties": {
            "JAVA_HOME": "/usr/lib/jvm/java-1.8.0"
          }
        }
      ],
      "Properties": {}
    },
    {
      "Classification": "spark-env",
      "Configurations": [
        {
          "Classification": "export",
          "Properties": {
            "JAVA_HOME": "/usr/lib/jvm/java-1.8.0"
          }
        }
      ],
      "Properties": {}
    }
  ]
EOF

  service_role = aws_iam_role.emr_service_role.arn

  depends_on = [ aws_iam_role_policy_attachment.emr_service_role_policy ]
}