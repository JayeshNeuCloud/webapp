
sleep 30

sudo apt-get update

sudo apt install unzip -y

# sudo apt install mysql-client -y
sudo groupadd csye6225
sudo useradd -s /bin/false -g csye6225 -d /opt/csye6225 -m csye6225
sudo mkdir /opt/csye6225/webapp
sudo mv /home/admin/webapp.zip /opt/csye6225/webapp/
cd /opt/csye6225/webapp/
sudo unzip webapp.zip
# sudo apt install mysql-client -y
# sudo apt install mariadb-server -y
# sudo npm audit fix
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo npm install
sudo wget https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb -P /tmp/
sudo dpkg -i /tmp/amazon-cloudwatch-agent.deb
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent
 
source_path="/opt/csye6225/webapp/opt/users.csv"
destination_path="/opt/"
 
# Move the file if it exists
[ -e "$source_path" ] && sudo cp "$source_path" "$destination_path" && echo "File 'users.csv' moved to '$destination_path'"

sudo mv /opt/csye6225/webapp/webapp.service /etc/systemd/system/webapp.service
sudo mv /opt/csye6225/webapp/cloudwatch-config.json /opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json


sudo chown -R csye6225:csye6225 /opt/csye6225/webapp/
sudo chmod -R 750 /opt/csye6225/webapp/
sudo systemctl daemon-reload
sudo systemctl enable webapp
sudo systemctl start webapp

