<<<<<<< HEAD
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
      
=======
resource "aws_security_group" "allow_access" {
  name        = "allow_access"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_subnet.main]

  lifecycle {
    ignore_changes = [
      ingress,
      egress,
    ]
  }

  tags = {
    name = "emr_test"
  }
}

resource "aws_vpc" "main" {
  cidr_block           = "168.31.0.0/16"
  enable_dns_hostnames = true

  tags = {
    name = "emr_test"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "168.31.0.0/20"

  tags = {
    name = "emr_test"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.r.id
}

data "aws_iam_policy_document" "emr_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticmapreduce.amazonaws.com"]
>>>>>>> 03e42b3da0c8fc71dfce0ab8e18aae32497f14ee
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

<<<<<<< HEAD
  depends_on = [ aws_iam_role_policy_attachment.emr_service_role_policy ]
}
=======
resource "aws_iam_role" "iam_emr_profile_role" {
  name               = "iam_emr_profile_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_instance_profile" "emr_profile" {
  name = "emr_profile"
  role = aws_iam_role.iam_emr_profile_role.name
}

data "aws_iam_policy_document" "iam_emr_profile_policy" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:*",
      "dynamodb:*",
      "ec2:Describe*",
      "elasticmapreduce:Describe*",
      "elasticmapreduce:ListBootstrapActions",
      "elasticmapreduce:ListClusters",
      "elasticmapreduce:ListInstanceGroups",
      "elasticmapreduce:ListInstances",
      "elasticmapreduce:ListSteps",
      "kinesis:CreateStream",
      "kinesis:DeleteStream",
      "kinesis:DescribeStream",
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:MergeShards",
      "kinesis:PutRecord",
      "kinesis:SplitShard",
      "rds:Describe*",
      "s3:*",
      "sdb:*",
      "sns:*",
      "sqs:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "iam_emr_profile_policy" {
  name   = "iam_emr_profile_policy"
  role   = aws_iam_role.iam_emr_profile_role.id
  policy = data.aws_iam_policy_document.iam_emr_profile_policy.json
}

resource "aws_emr_cluster" "cluster" {
  name          = "emr-test-arn"
  release_label = "emr-6.3.0"
  applications  = ["Spark"]
  
  additional_info = jsonencode({
    "keyPair" = "linuxkey.pem"
  })

  ec2_attributes {
    subnet_id                         = aws_subnet.main.id
    emr_managed_master_security_group = aws_security_group.allow_access.id
    emr_managed_slave_security_group  = aws_security_group.allow_access.id
    instance_profile                  = aws_iam_instance_profile.emr_profile.arn
  }

  master_instance_group {
    instance_type = "m5.xlarge"
  }

  core_instance_group {
    instance_count = 1
    instance_type  = "m5.xlarge"
  }

  tags = {
    role     = "rolename"
    dns_zone = "env_zone"
    env      = "env"
    name     = "name-env"
  }

  service_role = aws_iam_role.iam_emr_service_role.arn

  configurations_json = <<EOF
[
  {
    "classification": "bootstrap-action",
    "properties": {
      "name": "Custom action",
      "script_bootstrap_action": {
        "path": "s3://bucket-config-instance-5f6ht3687463847/bootstrap-script.sh"
      }
    }
  }
]
EOF
}

>>>>>>> 03e42b3da0c8fc71dfce0ab8e18aae32497f14ee
