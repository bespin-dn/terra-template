01.Architecture
=============
![Alt text](./01.png)

Resource
-----
* VPC, Subnet, Route Table
* IGW, NGW
* EC2
* ELB
* Security Group

Prerequisite
----
### 1. AWS Credential
*Terraform apply*을 실행할 서버에 AWS Credential 생성.
```bash
$ aws configure
AWS Access Key ID [None]:
AWS Secret Access Key [None]:
Default region name [None]:
Default output format [None]:
```
### 2. SSH Key 생성
SSH 접속을 위한 Public/Private Key를 AWS 콘솔에서 생성.

Usage
-----
### 1. Configuration
**terrform.tfvar** 내 설정 확인 및 알맞게 수정
```
context = {
    aws_credential_file = <Credential 파일 위치>
    aws_region = <리전>
    aws_profile = default

    project = "template-01"
}

vpc_cide = "10.10"
instance_type = <Web Instance Type>
key_name = <Key Pair 이름>
```

### 2. Run Command
```bash
$ terraform init
$ terraform plan
$ terraform apply