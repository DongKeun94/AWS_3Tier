# Key pair 생성
resource "aws_key_pair" "digda_key" {
  key_name   = "digda_key"
  public_key = file("../../.ssh/digda-key.pub")
}
