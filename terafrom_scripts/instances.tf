# Generate ssh_key
resource "tls_private_key" "ansible" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Get ssh_key
resource "aws_key_pair" "ansiblekey" {
  public_key = tls_private_key.ansible.public_key_openssh
}

resource "aws_instance" "web_Servers_A" {
  count                  = 1
  ami                    = var.test_ami
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  subnet_id              = element(aws_subnet.test_subnets.*.id, count.index)
  key_name               = var.key_name


  tags = {
    Name = "web_Servers_A"
    Type = "web_Instance"
  }

  # Copies the ssh_key file to new ec2.
  /*provisioner "file" {
    # Read ssh_key and copy to ansible
    content     = aws_key_pair.ansiblesshkey.public_key
    destination = "/home/ansible/.ssh/authorized_keys"
  }
*/
}

resource "aws_instance" "web_Servers_B" {
  count                  = 1
  ami                    = var.test_ami
  instance_type          = var.web_instance_type
  vpc_security_group_ids = [aws_security_group.test_sg.id]
  subnet_id              = element(aws_subnet.test_subnets.*.id, count.index)
  key_name               = var.key_name


  tags = {
    Name = "web_Servers_B"
    Type = "web_Instance"
  }

  # Copies the ssh_key file to new ec2.
  /*provisioner "file" {
    # Read ssh_key and copy to ansible
    content     = aws_key_pair.ansiblesshkey.public_key
    destination = "/home/ansible/.ssh/authorized_keys"
  }
*/
}

  resource "aws_instance" "web_Server_C" {
  count                  = 1
  ami                    = var.test_ami
  instance_type          = var.internal_instance_type
  vpc_security_group_ids = [aws_security_group.test_sg1.id]
  subnet_id              = element(aws_subnet.test_subnets.*.id, count.index)
  key_name               = var.key_name

  
  tags = {
    Name = "web_Servers_C"
    Type = "Internal_Instance"
  }

/* # Copies the ssh_key file to new ec2.
  provisioner "file" {
    # Read ssh_key and copy to ansible
    content     = aws_key_pair.ansiblesshkey.public_key
    destination = "/home/ansible/.ssh/authorized_keys"
  }
*/
}
