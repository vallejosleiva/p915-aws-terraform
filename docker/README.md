
1. Create Docker image:
./createImage.sh ENV ACCOUNT_ID REGION IMAGE_NAME IMAGE_VERSION

e.g.
./createImage.sh application-name 123456789012 us-east-1 application-name 1.0


2. Upload to ECR:
./uploadToECR.sh ACCOUNT_ID REGION REPO_NAME IMAGE_NAME IMAGE_VERSION

e.g.
./uploadToECR.sh 123456789012 us-east-1 application-name application-name 1.0
