### EBS Volume 생성 및 EC2 Instance와 연결 ###

# EBS Volume 생성
resource "aws_ebs_volume" "digda-ebs-web" {
  availability_zone = "ap-northeast-2a"
  size              = 40

  tags = {
    Name = "web-ebs"
  }
}

# WEB-A Instance와 연결
resource "aws_volume_attachment" "web_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.digda-ebs-web.id
  instance_id = aws_instance.digda-web-a.id

}


# EBS Volume 생성
resource "aws_ebs_volume" "digda-ebs-was" {
  availability_zone = "ap-northeast-2a"
  size              = 40

  tags = {
    Name = "was-ebs"
  }
}

# WAS-A Instance와 연결
resource "aws_volume_attachment" "was_ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.digda-ebs-was.id
  instance_id = aws_instance.digda-was-a.id

}
