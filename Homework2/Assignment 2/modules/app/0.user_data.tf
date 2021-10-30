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


#echo "0 */3 * * * root aws s3 cp /var/log/nginx/access.log  s3://$HOSTNAME-access.log" | sudo tee -a /etc/crontab
#echo -n "0 */3 * * * root aws s3 cp /var/log/nginx/access.log  s3://$HOSTNAME-access.log" >> /etc/crontab
