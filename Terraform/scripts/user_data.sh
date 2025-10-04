#!/bin/bash
set -ex

GIT_REPO="${git_repo}"
GIT_BRANCH="${git_branch}"
ROLE="${role}"

# update and install
yum update -y
# git & docker
yum install -y git
amazon-linux-extras enable docker
yum install -y docker
service docker start
usermod -a -G docker ec2-user

# docker-compose (v2 style) - adjust version as needed
curl -SL "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

cd /home/ec2-user
if [ ! -d "app" ]; then
  git clone "${GIT_REPO}" app
fi

cd app
git fetch --all || true
git checkout "${GIT_BRANCH}" || git checkout -b "${GIT_BRANCH}" origin/"${GIT_BRANCH}" || true

# Build & run based on role
if [ "${ROLE}" = "frontend" ]; then
  cd frontend || exit 0
  # adjust build/run commands according to your Dockerfile
  docker build -t blogify-frontend:${GIT_BRANCH} .
  docker run -d --name blogify-frontend -p 80:80 --restart unless-stopped blogify-frontend:${GIT_BRANCH}
fi

if [ "${ROLE}" = "backend" ]; then
  cd backend || exit 0
  docker build -t blogify-backend:${GIT_BRANCH} .
  docker run -d --name blogify-backend -p 5000:5000 --restart unless-stopped blogify-backend:${GIT_BRANCH}
  # Note: if you need MongoDB, either run a Mongo container here, or use managed Mongo / external DB in private subnet.
fi
