# Medusa ECS Deployment

This project deploys the Medusa headless commerce platform on AWS ECS with Fargate, including Infrastructure as Code with Terraform and CI/CD with GitHub Actions.

## Architecture

- **AWS ECS Fargate**: Container orchestration
- **Application Load Balancer**: Traffic distribution
- **VPC**: Network isolation
- **CloudWatch**: Logging and monitoring
- **ECR**: Container registry
- **GitHub Actions**: CI/CD pipeline

## Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured
3. **Terraform** >= 1.3.0
4. **Docker** installed
5. **GitHub** repository

## Quick Start

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd medusa-ecs-deployment
```

### 2. Configure AWS

```bash
aws configure
# Enter your AWS Access Key ID, Secret Access Key, and region
```

### 3. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Setup GitHub Secrets

In your GitHub repository, add these secrets:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### 5. Deploy Application

Push to main branch to trigger deployment:

```bash
git add .
git commit -m "Initial deployment"
git push origin main
```

## Configuration

### Terraform Variables

Edit `terraform/variables.tf` to customize:

- `aws_region`: AWS region (default: eu-north-1)
- `project_name`: Project name (default: medusa)
- `cpu`: CPU units (default: 512)
- `memory`: Memory in MB (default: 1024)
- `desired_count`: Number of tasks (default: 1)

### Environment Variables

The application uses these environment variables:
- `NODE_ENV`: production
- `DATABASE_TYPE`: sqlite
- `DATABASE_URL`: sqlite:///data/store.db
- `JWT_SECRET`: Authentication secret
- `COOKIE_SECRET`: Session secret

## Accessing the Application

After deployment, get the load balancer URL:

```bash
cd terraform
terraform output alb_url
```

### API Endpoints

- **Store API**: `http://<alb-dns>/store`
- **Admin API**: `http://<alb-dns>/admin`
- **Health Check**: `http://<alb-dns>/health`

## CI/CD Pipeline

The GitHub Actions workflow:

1. **Terraform**: Provisions/updates infrastructure
2. **Build**: Creates Docker image
3. **Push**: Uploads to ECR
4. **Deploy**: Updates ECS service

## Monitoring

### CloudWatch Logs

View logs in AWS Console:
- Log Group: `/ecs/medusa`
- Stream: `ecs/<task-id>`

### ECS Service Health

Check service health:
- ECS Console > Clusters > medusa-cluster > Services

## Scaling

### Manual Scaling

```bash
aws ecs update-service \
  --cluster medusa-cluster \
  --service medusa-service \
  --desired-count 3
```

### Auto Scaling

Add to `terraform/service.tf`:

```hcl
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 10
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
```

## Security

### Current Security Measures

- VPC with public subnets
- Security groups restricting traffic
- IAM roles with least privilege
- HTTPS termination at ALB (configure SSL certificate)

### Recommended Enhancements

1. **Private subnets** for ECS tasks
2. **NAT Gateway** for outbound internet access
3. **WAF** for web application firewall
4. **RDS** for production database
5. **ElastiCache** for Redis
6. **Secrets Manager** for sensitive data

## Troubleshooting

### Common Issues

1. **Service not starting**
   - Check CloudWatch logs
   - Verify security groups
   - Check health check path

2. **Can't access application**
   - Verify ALB listener rules
   - Check security group rules
   - Confirm target group health

3. **Build failures**
   - Check GitHub Actions logs
   - Verify AWS credentials
   - Confirm ECR repository exists

### Useful Commands

```bash
# View ECS service events
aws ecs describe-services --cluster medusa-cluster --services medusa-service

# Check task definition
aws ecs describe-task-definition --task-definition medusa-task

# View running tasks
aws ecs list-tasks --cluster medusa-cluster --service-name medusa-service

# Get load balancer status
aws elbv2 describe-load-balancers --names medusa-alb
```

## Cleanup

To destroy all resources:

```bash
cd terraform
terraform destroy
```

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

## License

MIT License - see LICENSE file for details
# Medusa ECS Deployment
# Medusa ECS Deployment
# Medusa ECS Deployment..
