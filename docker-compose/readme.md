# create appdata directory for services
mkdir -p /docker/appdata/sonarr

# install service file
sudo cp sonarr.service /etc/systemd/system

# enable service in system.d
sudo systemctl enable sonarr

# start service
sudo systemctl start sonarr


found that docker version >= 28.0.0 makes containers using gluetun lose connection in raspian

To check you current version run
apt list --installed docker-ce

 To downgrade your docker to 27.5.1, run:

sudo apt install docker-compose-plugin=2.32.4-1~debian.12~bookworm docker-ce-cli=5:27.5.1-1~debian.12~bookworm docker-buildx-plugin=0.20.0-1~debian.12~bookworm docker-ce=5:27.5.1-1~debian.12~bookworm docker-ce-rootless-extras=5:27.5.1-1~debian.12~bookworm

Run sudo systemctl restart docker and check if this fixed your problem.

To make sure these packages don't upgrade, run:

sudo apt-mark hold docker-compose-plugin=2.32.4-1~debian.12~bookworm docker-ce-cli=5:27.5.1-1~debian.12~bookworm docker-buildx-plugin=0.20.0-1~debian.12~bookworm docker-ce=5:27.5.1-1~debian.12~bookworm docker-ce-rootless-extras=5:27.5.1-1~debian.12~bookworm

If you ever want them to start upgrading again, run the same command with unhold instead of hold 