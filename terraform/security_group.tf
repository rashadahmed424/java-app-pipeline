# Define a security group to allow SSH access
resource "aws_security_group" "my_jenkins_security_group" {
  name_prefix = "terraform-sg-"
  description  = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from any IP address
  }

    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from any IP address to jenkins container 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "my_webserver_security_group" {
  name_prefix = "terraform-webserver-sg-"
  description  = "Allow SSH inbound traffic"


  vpc_id = aws_vpc.my_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from any IP address
  }

    ingress {
    from_port   = 90
    to_port     = 90
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from any IP address to nginx load  balancer 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "rashad-key-pair" 
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file
  tags={
    Name="rashad_key"
  }

}