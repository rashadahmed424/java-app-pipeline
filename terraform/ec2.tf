
# Define the EC2 instance
resource "aws_instance" "jenkins_server" {
  ami           ="ami-0182f373e66f89c85"
  instance_type = "t2.micro"         # used due to free tier account, needs more resources
  vpc_security_group_ids = [aws_security_group.my_jenkins_security_group.id]
  subnet_id     = aws_subnet.my_subnet.id
  key_name = aws_key_pair.my_key_pair.key_name
  associate_public_ip_address = true

   root_block_device {
    volume_size = 20  # Size in GiB
    volume_type = "gp3"  # Default volume type, you can also use "gp2"
    iops        = 9000 # Adjust this to the desired IOPS value (min 3000 for gp3)
    throughput  = 200   # Throughput in MiB/s (between 125 MiB/s and 1000 MiB/s)
   
    delete_on_termination = true  # Automatically deletes the volume when instance is terminated
  }
  tags={
    Name="jenkins_server"
  }


}

resource "aws_instance" "web_server" {
  ami           ="ami-0182f373e66f89c85"
  instance_type = "t2.micro"               
  vpc_security_group_ids = [aws_security_group.my_webserver_security_group.id]
  subnet_id     = aws_subnet.my_subnet.id
  key_name = aws_key_pair.my_key_pair.key_name
  associate_public_ip_address = true

  tags={
    Name="web_server"
  }

}
