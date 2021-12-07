MEDIA_PATH="/var/www/localhost/"
INDEX_PATH=$MEDIA_PATH"index.html"
HTTPD_CONF_PATH="/etc/httpd/conf.d/"

sudo mkdir -p $MEDIA_PATH && sudo touch $INDEX_PATH
sudo cat /home/vagrant/shared/index.html > $INDEX_PATH

sudo mkdir -p $HTTPD_CONF_PATH
sudo cat /home/vagrant/shared/localhost.conf > /etc/httpd/conf.d/localhost.conf

chcon -Rt httpd_sys_content_t $MEDIA_PATH

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt -subj "/C=UA/CN=localhost/L=Lviv/O=ITSU"

sudo yum install -y epel-release

sudo yum install -y httpd

sudo yum install -y mod_ssl

sudo httpd -t

sudo systemctl start httpd