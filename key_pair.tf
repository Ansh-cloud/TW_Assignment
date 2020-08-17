resource "aws_key_pair" "tw" {
  key_name   = "tw"
  public_key = "${file("tw.pub")}"
}