AWS_PROFILE ?=
STACK_NAME ?= docker-registry-v2
DNS_ZONE ?= registry
DNS_PREFIX ?= example.com
SSL_CERT_ARN ?=
ADMIN_SECURITY_GROUP ?=
VPC_ID ?=
S3_BUCKET ?=

create:
	aws --profile $(AWS_PROFILE) cloudformation create-stack \
	--stack-name $(STACK_NAME) \
	--template-body file://$$(pwd)/docker-registry.json \
	--parameters ParameterKey=RegistryAuth,ParameterValue="$(REGISTRY_AUTH)" \
	ParameterKey=KeyName,ParameterValue=$(KEY_NAME) \
	ParameterKey=VpcId,ParameterValue=$(VPC_ID) \
	ParameterKey=S3Bucket,ParameterValue=$(S3_BUCKET) \
	ParameterKey=DnsPrefix,ParameterValue=$(DNS_PREFIX) \
	ParameterKey=DnsZone,ParameterValue=$(DNS_ZONE) \
	ParameterKey=Subnets,ParameterValue="$(SUBNETS)" \
	ParameterKey=SslCertificate,ParameterValue="$(SSL_CERT_ARN)" \
	ParameterKey=AdminSecurityGroup,ParameterValue=$(ADMIN_SECURITY_GROUP) \
	--capabilities CAPABILITY_IAM

delete:
	aws --profile $(AWS_PROFILE) cloudformation delete-stack \
	--stack-name $(STACK_NAME)
