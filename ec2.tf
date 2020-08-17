resource "aws_instance" "web" {
  ami           = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pub-sub1.id}"
  vpc_security_group_ids = ["${aws_security_group.web_sg.id}"]
  key_name = "RHEL-Mum"
  user_data = "${file("bootstrap.sh")}"
  tags = {
    Name = "Web"
    Enviromnment = "stage"
  }
}
resource "aws_instance" "DB" {
  ami           = "ami-052c08d70def0ac62"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.pri-sub1.id}"
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  key_name = "RHEL-Mum"
  user_data = "${file("bootstrapdb.sh")}"
  tags = {
   Name = "DB"
    Enviromnment = "stage"
  }
}