# Specify the provider
provider "aws" {
  region = "us-east-1"  # Change to your desired region
}

# Create a security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change this to restrict access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"  # Change to your desired instance type

  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyInstance"
  }

  # Uncomment the following line if you want to assign a key pair for SSH access
  # key_name = "your-key-pair-name"  # Replace with your key pair name
}

# Output the public IP address of the instance
output "instance_ip" {
  value = aws_instance.my_instance.public_ip
}
