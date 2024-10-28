ssh:
	ssh -i './ssh/id_rsa' ubuntu@vps-9b9aea12.vps.ovh.net

up:
	sudo docker compose up -d

down:
	sudo docker compose down