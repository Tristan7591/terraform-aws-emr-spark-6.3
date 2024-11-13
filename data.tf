data "aws_vpc""default"{
    default = true
}

data "aws_subnet" "default"{
    vpc_id = data.aws_vpc.default.id
    availability_zone = "${data.aws_region.current.name}a" #a is a reference to first avaibility zone
    default_for_az = true
}
data "aws_region" "current"{}