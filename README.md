Cloud-Native Nightmares: The SSM Command and IAM Chronicles
When Automation Meets Malice: The Dark Reality of Cloud-Native Security.
A Multistage Attack Path: From EC2 to Ransomware on S3

We will explore a multistage attack path that begins with an EC2 instance having ssm permissions, ultimately leading to the deployment of ransomware on an S3 bucket.
Overview of the Attack Scenario

    Two EC2 Servers Managed by Systems Manager
    Web Server: Has the ssm:SendCommand policy attached.
    S3 Access EC2: This server has IAM access to an S3 bucket containing sensitive .txt data.

Blog: https://medium.com/@shashvik/cloud-native-nightmares-the-ssm-command-and-iam-chronicles-a4280e15e46c

Disclaimer: The content of this article is intended solely for educational purposes. The information shared here reflects my personal experience in creating ransomware and is not intended to promote or endorse malicious activities. I take no responsibility for any actions taken based on this information. Readers are encouraged to use this knowledge responsibly and ethically, focusing on improving cybersecurity practices rather than exploiting vulnerabilities.
