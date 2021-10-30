locals {
  nginx-webserver = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sed -i "s/nginx/Grandpa's Whiskey - $HOSTNAME.srv/g" /var/www/html/index.nginx-debian.html
sed -i '15,23d' /var/www/html/index.nginx-debian.html
service nginx restart
EOF
}

# Upload Access Log To S3 Now + Every Hour
# echo "0 * * * * root aws s3 cp /var/log/nginx/access.log  s3://$HOSTNAME-access.log" | sudo tee -a /etc/crontab
