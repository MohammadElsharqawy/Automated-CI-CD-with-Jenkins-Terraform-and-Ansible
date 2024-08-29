// Target groups
resource "aws_lb_target_group" "my_tg_alb" {
 name     = "target-group-a"
 port     = 3000
 protocol = "HTTP"
 vpc_id   = module.network.vpc_id
}

// Target group attachment
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
 target_group_arn = aws_lb_target_group.my_tg_alb.arn
 target_id        = aws_instance.application1.id
 port             = 3000
}


// ALB
resource "aws_lb" "public-elb" {
 name               = "public-elb"
 internal           = false
 load_balancer_type = "application"
 security_groups    = [aws_security_group.elb_sg.id]
 subnets            = [module.network.public_subnet1_id, module.network.public_subnet2_id]
}


// Listener
resource "aws_lb_listener" "listener" {
 load_balancer_arn = aws_lb.public-elb.arn
 port              = 80
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.my_tg_alb.arn
 }
}
