# Security Design Decisions

## Implemented Controls

### ✅ Encryption at Rest (AES-256)
**Decision:** Use AWS-managed encryption (SSE-S3) instead of KMS.  
**Rationale:** 
- AES-256 is FIPS 140-2 compliant and suitable for most use cases
- No additional cost
- Simpler key management for learning environment
- KMS would add $1/month + request costs
**Risk:** Lower audit granularity compared to KMS
**Mitigation:** CloudTrail logs all S3 API calls

### ✅ Versioning Enabled
**Decision:** Keep all object versions with 90-day retention for non-current versions.  
**Rationale:**
- Protects against accidental deletion
- Ransomware defense mechanism
- Compliance requirement for many standards
**Cost Impact:** Minimal for lab usage

### ❌ Cross-Region Replication (Not Implemented)
**Decision:** Skip for Phase 1  
**Rationale:**
- Doubles storage costs
- Data transfer costs between regions
- Enterprise feature not critical for security fundamentals
- Can be added in Phase 2 for advanced architecture
**Risk:** No disaster recovery across regions
**Mitigation:** Versioning provides recovery within region

### ✅ Public Access Block (All 4 Settings)
**Decision:** Block all public access at bucket level  
**Rationale:**
- Prevents accidental public exposure (Capital One-style breaches)
- Defense in depth - even if policy allows public, bucket-level block overrides
- Zero valid use case for public access in this security lab

### ✅ Lifecycle Management
**Decision:** 
- Abort incomplete multipart uploads after 7 days
- Transition to Glacier after 30 days
- Delete non-current versions after 90 days  
**Rationale:**
- Prevents cost accumulation from failed uploads
- Optimizes storage costs
- Balances recovery needs with cost management

### ❌ Event Notifications (Not Implemented)
**Decision:** Skip for Phase 1  
**Rationale:**
- Requires additional infrastructure (SNS/SQS/Lambda)
- Advanced feature beyond basic security controls
- Can be added in Phase 3 for automated workflows
**Use Case for Future:** Automated virus scanning, data classification

## Security Testing

All controls validated via:
- AWS CLI commands
- Terraform state inspection
- Manual verification in AWS Console
- Automated security scanning (Checkov, tfsec, TFLint)

## Compliance Alignment

This configuration aligns with:
- ✅ AWS Well-Architected Framework (Security Pillar)
- ✅ CIS AWS Foundations Benchmark
- ✅ NIST Cybersecurity Framework (Protect function)
- ⚠️ Partial: PCI-DSS, HIPAA (would require KMS for full compliance)
