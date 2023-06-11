# terra-template
For Terraform template


Prerequisite
=============
### 1. AWS Credential
*Terraform apply*을 실행할 서버에 AWS Credential 생성.   
<span style="color:red">해당 파일은 권한을 가지고 있기 때문에, 관리에 유의.
```bash
$ vi aws.cred

[default]
aws_access_key_id = 
aws_secret_access_key = 
```

### 2. SSH Key 생성
SSH 접속을 위한 Public/Private Key를 AWS 콘솔에서 생성.

### 3. terraform Install
[Terraform][URL] 공식 홈페이지에서 실행 파일 다운로드 또는 아래 명령어 통해 설치.

[URL]: https://developer.hashicorp.com/terraform/downloads

```bash
## Amazon Linux
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

## Ubuntu
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
`terrafom version`으로 정상 설치 확인.

### 4. Git Clone
```bash
git clone https://github.com/bespin-dn/terra-template.git
```