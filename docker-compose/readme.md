# create appdata directory for services
mkdir -p /docker/appdata/sonarr

# install service file
sudo cp sonarr.service /etc/systemd/system

# enable service in system.d
sudo systemctl enable sonarr

# start service
sudo systemctl start sonarr