#!/bin/bash

# 1 means the first argu and -default means if it's empty !
ACTION=${1:-default}
VERSION=1.0.1


function show_version() {

echo $VERSION

}

function start() {

sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
sudo chkconfig nginx on
sudo aws s3 cp s3://almu5473-assignment-webserver/index.html /usr/share/nginx/html/index.html
sudo service nginx start

}


function delete() {

sudo service nginx stop
sudo rm /usr/share/nginx/html
yum remove nginx -y

}

function help() {

cat << EOF

OPTIONS:
	 -h | --help Display help
	 -r | --delete Delete all html files and stop+remove Ngonx
 	 -v | --version Version number
No Argument |Will Install Package,Update,Configur nginx,copy from S3, and Start Nginx service 

EOF

}

case "$ACTION" in
	-v|--version)
		show_version
		;;
	default)
		start
		;;
	-r|--remove)
		delete
		;;
	-h|--help)
		help
		;;

	*)
	exit

esac
