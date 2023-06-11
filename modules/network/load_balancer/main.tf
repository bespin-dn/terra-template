resource "aws_lb_target_group" "default_lb_http_tg" {
  name = "${var.name}-TG"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  tags = var.tag_name
}

resource "aws_lb_target_group_attachment" "default_lb_a_tg_att" {
  target_group_arn = aws_lb_target_group.default_lb_http_tg.arn
  target_id = var.ec2_a_id
  port = 80
}
resource "aws_lb_target_group_attachment" "default_lb_c_tg_att" {
  target_group_arn = aws_lb_target_group.default_lb_http_tg.arn
  target_id = var.ec2_c_id
  port = 80
}

resource "aws_lb" "default_web_lb" {
  name = var.name
  load_balancer_type = var.lb_type
  subnets = [ var.public_subnet_a_id, var.public_subnet_c_id ]
  security_groups = [ var.alb_sg_id ]
  tags = var.tag_name
}

resource "aws_lb_listener" "default_lb_listener" {
  load_balancer_arn = aws_lb.default_web_lb.arn
  protocol = "HTTP"
  port = 80
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.default_lb_http_tg.arn
  }
}