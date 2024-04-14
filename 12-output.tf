output "load_balancer_dns_name" {
  value       = "http://${aws_lb.app1_alb.dns_name}"
  description = "The DNS name of the load balancer"
}
