#!/bin/bash
# Install neccesary packages
yum update -y
amazon-linux-extras install -y php8.0
amazon-linux-extras install -y epel
amazon-linux-extras install -y python3.8
amazon-linux-extras install -y docker
yum install -y jq
yum install mysql -y
yum install httpd -y
yum install -y git
#cd /home/ec2-user
#python3 -m venv /home/ec2-user/venv
#source /home/ec2-user/venv/bin/activate
# Set timezone
timedatectl set-timezone Europe/Madrid

# Clone git repo and copy to html folder
cd /tmp
git clone ${git_uri}
cp -r .${git_uri_app-path}www/* /var/www
cp -r .${git_uri_app-path}docker /var
#cp -r .${git_uri_app-path}scripts /var
#cp -r .${git_uri_app-path}www/* /var/docker/web_init

# Create .env
touch /var/www/.env
echo "DBHOST=127.0.0.1" >> /var/www/.env
echo "DBNAME=${db_name}" >> /var/www/.env
echo "DBTABLE=${db_table}" >> /var/www/.env
echo "DBPORT=${db_port}" >> /var/www/.env
echo "DBUSER=${db_user}" >> /var/www/.env
echo "DBPASS=${db_pass}" >> /var/www/.env

# Copy .env to docker and scripts
#cp /var/www/.env /var/docker/web_init
#cp /var/www/.env /var/docker/script_init

# Start PHP server and fix permissions
systemctl start httpd
systemctl enable httpd
chkconfig httpd on
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# Start Docker
service docker start
chkconfig docker on
usermod -a -G docker ec2-user

# Create docker-compose.yml
cd /var/docker
touch docker-compose.yml
cat > docker-compose.yml <<EOF
${docker_file}
EOF

# Install Docker compose
cd /home/ec2-user
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose -f /var/docker/docker-compose.yml up -d

# Execute phyton script check 
#pip3 install -r /var/docker/script_init/requirements.txt
#python3 /var/docker/script_init/rcheckScript.py
