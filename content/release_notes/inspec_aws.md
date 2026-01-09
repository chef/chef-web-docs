+++
title = "Chef InSpec AWS Cloud Resource release notes"
draft = false
product = ["inspec"]
linkTitle = "Chef InSpec AWS Cloud Resources"
summary = "Chef InSpec AWS Cloud Resource release notes"

[menu]
  [menu.release_notes]
    title = "AWS Cloud Resources"
    identifier = "release_notes/inspec/InSpec AWS"
    parent = "release_notes/inspec"
+++

<!-- markdownlint-disable-file -->
<!-- cSpell:disable  -->
<!-- vale off -->

## AWS Cloud Resource 2022-01-07

### New AWS Cloud Resources

- [Lambda Version](https://github.com/inspec/inspec-aws/pull/774)
- [RDS DB Proxy](https://github.com/inspec/inspec-aws/pull/771)
- [RDS DB Proxy Endpoint](https://github.com/inspec/inspec-aws/pull/772)
- [RDS DB Security Group](https://github.com/inspec/inspec-aws/pull/782)
- [RDS Event Subscription](https://github.com/inspec/inspec-aws/pull/781)
- [RDS Global Cluster](https://github.com/inspec/inspec-aws/pull/780)
- [RDS DB Proxy Target Group](https://github.com/inspec/inspec-aws/pull/773)
- [S3 Bucket Policy](https://github.com/inspec/inspec-aws/pull/783)
- [Signer Profile Permission](https://github.com/inspec/inspec-aws/pull/777)
- [SSM Maintainance Window](https://github.com/inspec/inspec-aws/pull/798)
- [WAF Rule](https://github.com/inspec/inspec-aws/pull/802)
- [WAF Byte Match Set](https://github.com/inspec/inspec-aws/pull/803)
- [WAF XSS Match Support](https://github.com/inspec/inspec-aws/pull/807)
- [WAF SQL Injection Match Set](https://github.com/inspec/inspec-aws/pull/806)
- [WAF Size Constraint Set](https://github.com/inspec/inspec-aws/pull/805)
- [WAF IP Set](https://github.com/inspec/inspec-aws/pull/804)
- [WAF Web ACL](https://github.com/inspec/inspec-aws/pull/808)

### Improvements

- [Improved the `aws_hosted_zones` resource so it can handle queries that return more than 100 hosted zones](https://github.com/inspec/inspec-aws/pull/811).
- [Resolved issue with activesupport when running Ruby versions earlier than 2.7.0](https://github.com/inspec/inspec-aws/pull/816).
- [Added the ability to verify the template body of a CloudFormation template in the `aws_cloudformation_template` resource](https://github.com/inspec/inspec-aws/pull/770). Thanks [@jb897](https://github.com/jb897)!

## AWS Cloud Resource 2021-11-30

### New AWS Cloud Resources

- [IAM SSH Public Key](https://github.com/inspec/inspec-aws/pull/695)
- [Cloudwatch Logs Streams](https://github.com/inspec/inspec-aws/pull/684)
- [EC2 Carrier Gateway](https://github.com/inspec/inspec-aws/pull/686)
- [Logs Subscription Filter](https://github.com/inspec/inspec-aws/pull/685)
- [Config Recorder](https://github.com/inspec/inspec-aws/pull/750)
- [EC2 Capacity Reservation](https://github.com/inspec/inspec-aws/pull/663)
- [EC2 Customer Gateway](https://github.com/inspec/inspec-aws/pull/664)
- [Cloudformation Template](https://github.com/inspec/inspec-aws/pull/753)
- [Amplify App](https://github.com/inspec/inspec-aws/pull/637)
- [EC2 Volume Attachments](https://github.com/inspec/inspec-aws/pull/629)
- [Network Firewall's Firewall Policies](https://github.com/inspec/inspec-aws/pull/630)
- [Network Manager Customer Gateway Association](https://github.com/inspec/inspec-aws/pull/628)
- [Network Firewall Rule Group](https://github.com/inspec/inspec-aws/pull/627)
- [Network Firewall Logging Configuration](https://github.com/inspec/inspec-aws/pull/626)
- [Network Firewall's Firewall](https://github.com/inspec/inspec-aws/pull/625)
- [EC2 Spot Fleet](https://github.com/inspec/inspec-aws/pull/624)
- [Amplify Branch](https://github.com/inspec/inspec-aws/pull/638)
- [SDB Resource](https://github.com/inspec/inspec-aws/pull/654)
- [EMR Security Configuration](https://github.com/inspec/inspec-aws/pull/766)
- [EMR Cluster Resource](https://github.com/inspec/inspec-aws/pull/758)
- [Cloudfront Public Key Resource](https://github.com/inspec/inspec-aws/pull/682)
- [Cloudfront Key Group](https://github.com/inspec/inspec-aws/pull/679)
- [Cloudwatch Composite Alarm](https://github.com/inspec/inspec-aws/pull/676)
- [Cloudfront Streaming Distribution](https://github.com/inspec/inspec-aws/pull/674)
- [Cloudwatch Metric Stream](https://github.com/inspec/inspec-aws/pull/657)
- [Cloudfront Realtime Log Config](https://github.com/inspec/inspec-aws/pull/673)
- [Lambda Layer Version Permission](https://github.com/inspec/inspec-aws/pull/671)
- [Insight Rules](https://github.com/inspec/inspec-aws/pull/659)
- [S3 Access Point](https://github.com/inspec/inspec-aws/pull/660)
- [EC2 EIP Association](https://github.com/inspec/inspec-aws/pull/666)
- [EC2 Egress Only Internet Gateway](https://github.com/inspec/inspec-aws/pull/665)
- [EC2 Fleet](https://github.com/inspec/inspec-aws/pull/667)
- [EC2 Host](https://github.com/inspec/inspec-aws/pull/668)
- [EC2 Placement Group](https://github.com/inspec/inspec-aws/pull/669)
- [Securityhub Hub](https://github.com/inspec/inspec-aws/pull/747)
- [Cloudwatch Log Destination](https://github.com/inspec/inspec-aws/pull/683)
- [EC2 Client VPN Route](https://github.com/inspec/inspec-aws/pull/716)
- [Lambda Code Signing Config](https://github.com/inspec/inspec-aws/pull/776)
- [Lambda Event Invoke Config](https://github.com/inspec/inspec-aws/pull/672)
- [SES Receipt Rule](https://github.com/inspec/inspec-aws/pull/754)
- [SES Template](https://github.com/inspec/inspec-aws/pull/756)
- [SES Receipt Rule Set](https://github.com/inspec/inspec-aws/pull/755)
- [Lambda Alias](https://github.com/inspec/inspec-aws/pull/775)
- [Network Manager Device](https://github.com/inspec/inspec-aws/pull/537)

## AWS Cloud Resource 2021-11-08

### New AWS Cloud Resources

- [MQ Broker](https://github.com/inspec/inspec-aws/pull/635)
- [Simple Notification Service (SNS) Subscription](https://github.com/inspec/inspec-aws/pull/698)
- [RDS DB Cluster Snapshot](https://github.com/inspec/inspec-aws/pull/696)
- [EC2 Placement Groups](https://github.com/inspec/inspec-aws/pull/535)
- [EC2 Network Interface Permission](https://github.com/inspec/inspec-aws/pull/536)
- [Cloudfront Cache Policy](https://github.com/inspec/inspec-aws/pull/644)
- [Cloudfront Origin Request Policy](https://github.com/inspec/inspec-aws/pull/656)
- [Cloudwatch Dashboard](https://github.com/inspec/inspec-aws/pull/658)
- [IAM Server Certificates](https://github.com/inspec/inspec-aws/pull/511)
- [Traffic Mirror Target](https://github.com/inspec/inspec-aws/pull/500)
- [Client VPN Target Network Association](https://github.com/inspec/inspec-aws/pull/746)
- [Client VPN Authorisation Rules](https://github.com/inspec/inspec-aws/pull/717)
- [Client VPN Endpoint](https://github.com/inspec/inspec-aws/pull/715)
- [Cloudwatch Anomaly Detector](https://github.com/inspec/inspec-aws/pull/675)
- [Signer Signing Profile](https://github.com/inspec/inspec-aws/pull/670)

### Improvements

- [Removed duplicate resource](https://github.com/inspec/inspec-aws/pull/697)

## AWS Cloud Resource 2021-10-13

### New AWS Cloud Resources

- [EC2 Prefix List](https://github.com/inspec/inspec-aws/pull/538)
- [Network Manager Global Network](https://github.com/inspec/inspec-aws/pull/539)
- [CloudFormation Stack Set](https://github.com/inspec/inspec-aws/pull/655)
- [API Gateway Authorizer](https://github.com/inspec/inspec-aws/pull/641)
- [API Gateway Base Path Mapping](https://github.com/inspec/inspec-aws/pull/643)
- [API Gateway Client Certificate](https://github.com/inspec/inspec-aws/pull/642)
- [API Gateway Account](https://github.com/inspec/inspec-aws/pull/639)
- [API Gateway API Key](https://github.com/inspec/inspec-aws/pull/640)
- [CloudFront Origin Access Identities](https://github.com/inspec/inspec-aws/pull/645)

### Improvements

- [Added inline policy names in IAM resource pack](https://github.com/inspec/inspec-aws/pull/621)
- [ELB new attributes added to existing resource ELB pack](https://github.com/inspec/inspec-aws/pull/623)
- [Added tag attribute in KMS key resource pack](https://github.com/inspec/inspec-aws/pull/522)
- [Changed an attribute in cloudfront resource pack](https://github.com/inspec/inspec-aws/pull/648)

### Bug Fixes

- [Fixed a typo in aws_ec2_instances resource pack](https://github.com/inspec/inspec-aws/pull/649)

## AWS Cloud Resource 2021-10-01

### New AWS Cloud Resources

- RDS Snapshot
- Transit Gateway Multicast Domain Association
- Transit Gateway Multicast Domain
- Transit Gateway Group Member
- Transit Gateway Connect
- Transit Gateway Multicast Group Source
- EC2 VPC Peering Connection
- EC2 VPN Gateway Route Propagation
- EC2 Volume Attachment
- OIDC Provider
- Traffic Mirror Filter
- Traffic Mirror Session
- Cloudfront Distribution
- Virtual MFA Audit
- Service Role Deletion Status
- S3 Bucket Objects (plural)
- VPN Connection Route
- EC2 Network Insights Analysis
- EC2 Internet Gateway
- EC2 Network Insights Path
- EC2 Network Interface
- EC2 Network Interface Attachment

### Improvements

- Added the origin path attribute in Cloud front distribution resource

### Bug Fixes

- Dynamodb tables fails when we've large number of dynamodb tables that requires pagination.
