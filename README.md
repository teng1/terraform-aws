# terraform-aws
This repository provides an example AWS infrastructure built on terraform. Project is based on the hashicorp best-practices repository with support for multiple private subnets, in this example using *Public, Private, Protected* subnets. AWS network design is based on AWS security compliance templates, *NIST, PCI DSS, UK-OFFICIAL*.

```
10.0.0.0/16:
    10.0.0.0/18 — AZ A
        10.0.0.0/19 — Private
        10.0.32.0/19
               10.0.32.0/20 — Public
               10.0.48.0/20
                   10.0.48.0/21 — Protected
                   10.0.56.0/21 — Spare
    10.0.64.0/18 — AZ B
        10.0.64.0/19 — Private
        10.0.96.0/19
                10.0.96.0/20 — Public
                10.0.112.0/20
                    10.0.112.0/21 — Protected
                    10.0.120.0/21 — Spare
    10.0.128.0/18 — Spare
    10.0.192.0/18 — Spare
```
references
https://medium.com/aws-activate-startup-blog/practical-vpc-design-8412e1a18dcc
https://aws.amazon.com/quickstart/architecture/
