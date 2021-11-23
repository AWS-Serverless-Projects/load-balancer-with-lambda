output "lb_address" {
  value = aws_lb.load-balancer.dns_name
  description = "DNS of load balancer"
}
