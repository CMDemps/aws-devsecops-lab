# AWS DevSecOps Lab - Secure S3 Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat&logo=amazonaws&logoColor=white)
![Security](https://img.shields.io/badge/Security-Critical-red)

**Production-grade AWS S3 infrastructure with automated security scanning**

This project demonstrates enterprise-level cloud security practices using Infrastructure as Code (Terraform) with automated security scanning in CI/CD pipelines.

## 🎯 Project Goals

- Implement **defense-in-depth** security controls for AWS S3
- Demonstrate **Infrastructure as Code** best practices
- Automate security scanning in CI/CD pipelines
- Showcase **DevSecOps** methodology

## 🏗️ Architecture

### Infrastructure Components

- **Primary S3 Bucket**: Secure storage with multiple security layers
- **Logging S3 Bucket**: Centralized access logs
- **Encryption**: AES-256 server-side encryption at rest
- **Versioning**: Enabled for ransomware protection and recovery
- **Access Controls**: Public access blocked at all levels
- **Audit Logging**: All access attempts logged to separate bucket
- **Lifecycle Rules**: Automated cost optimization

### Security Controls (6 Layers)

1. **🔒 Encryption at Rest** - AES-256 encryption on all objects
2. **🔒 Encryption in Transit** - TLS/HTTPS enforcement via bucket policy
3. **🔒 Versioning** - Protection against accidental deletion and ransomware
4. **🔒 Access Logging** - Complete audit trail of all access attempts
5. **🔒 Public Access Block** - Prevents accidental data exposure
6. **🔒 Lifecycle Management** - Automated data retention and archival

## 🛠️ Technologies Used

- **Terraform** - Infrastructure as Code
- **AWS S3** - Object storage
- **AWS IAM** - Access management
- **GitHub Actions** - CI/CD pipeline
- **Checkov** - Infrastructure security scanning
- **tfsec** - Terraform security analysis
- **TFLint** - Terraform linting

## 📋 Prerequisites

- AWS Account with appropriate IAM permissions
- Terraform >= 1.0
- AWS CLI configured with credentials
- Git

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR-USERNAME/aws-devsecops-lab.git
cd aws-devsecops-lab/terraform
```

### 2. Configure Variables

Edit `variables.tf` to customize:
- `bucket_name` - Must be globally unique
- `aws_region` - Default is us-east-1

### 3. Initialize Terraform
```bash
terraform init
```

### 4. Review the Plan
```bash
terraform plan
```

### 5. Deploy Infrastructure
```bash
terraform apply
```

Type `yes` when prompted.

### 6. Verify Deployment
```bash
# List created buckets
aws s3 ls

# Verify encryption
aws s3api get-bucket-encryption --bucket YOUR-BUCKET-NAME

# Verify versioning
aws s3api get-bucket-versioning --bucket YOUR-BUCKET-NAME
```

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

Type `yes` when prompted.

**⚠️ Warning:** This will delete all buckets and their contents.

## 🔒 Security Features Explained

### Encryption at Rest
All objects are automatically encrypted using AES-256 encryption. This protects data if physical storage media is compromised.

### Encryption in Transit
Bucket policy enforces TLS/HTTPS connections only, preventing man-in-the-middle attacks.

### Versioning
Every version of every object is retained, allowing recovery from:
- Accidental deletion
- Accidental overwrite
- Ransomware attacks

### Access Logging
All access attempts are logged with:
- Requester identity
- Timestamp
- Request type (GET, PUT, DELETE)
- Response status
- Source IP address

### Public Access Block
Four-layer protection against accidental public exposure:
- Block public ACLs
- Ignore public ACLs
- Block public bucket policies
- Restrict public bucket access

### Lifecycle Rules
- Delete non-current versions after 90 days
- Transition objects to Glacier after 30 days for cost savings

## 📊 Cost Estimation

**Free Tier Eligible:**
- S3: 5GB storage free for 12 months
- 20,000 GET requests
- 2,000 PUT requests

**Estimated Monthly Cost (Post Free Tier):**
- S3 Storage: <$0.50/month (for typical lab usage)
- S3 Requests: <$0.10/month
- **Total: <$1/month**

## 🎓 Learning Outcomes

- ✅ Infrastructure as Code with Terraform
- ✅ AWS S3 security best practices
- ✅ Defense-in-depth security principles
- ✅ Compliance and auditing requirements
- ✅ CI/CD pipeline security scanning
- ✅ DevSecOps methodology

## 📚 References

- [AWS S3 Security Best Practices](https://docs.aws.amazon.com/AmazonS3/latest/userguide/security-best-practices.html)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

## 📝 License

This project is for educational and portfolio purposes.

## 👤 Author

**Clayton Demps** - Security Analyst | Cloud Security Enthusiast

💼 [LinkedIn Profile](https://www.linkedin.com/in/claytondemps)  
