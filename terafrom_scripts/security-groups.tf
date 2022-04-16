resource "aws_security_group" "test_sg" {
  name        = "Allow_All_Ports"
  description = "Allow All Ports All Protocals"
  vpc_id      = aws_vpc.test.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
resource "aws_security_group" "test_sg1" {
  name        = "Allow_QUAKE_III_ARENA_Ports"
  description = "Allow Quake III Arena Port"
  vpc_id      = aws_vpc.test.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["173.69.38.20/27950"]
  }
}
