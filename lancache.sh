# apt update && apt upgrade -y
# sudo apt install curl -y
# sudo curl -sSL https://get.docker.com/ | sh
# sudo systemctl status docker
export HOST_IP=`hostname -I | cut -d' ' -f1`
docker run --restart unless-stopped --name lancache-dns --detach -p 53:53/udp -e USE_GENERIC_CACHE=true -e LANCACHE_IP=$HOST_IP pegasy/lancachenet_lancache-dns:latest
docker run --restart unless-stopped --name lancache --detach -v /cache/data:/data/cache -v /cache/logs:/data/logs -p 80:80  pegasy/lancachenet_monolithic:latest
docker run --restart unless-stopped --name sniproxy --detach -p 443:443 pegasy/lancachenet_sniproxy:latest
echo Please configure your router/dhcp server to serve dns as $HOST_IP
