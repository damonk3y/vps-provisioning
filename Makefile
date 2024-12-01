ssh:
	ssh -i './ssh/id_rsa' ubuntu@vps-9b9aea12.vps.ovh.net

build:
	sudo docker compose build

up: build
	sudo docker compose up -d

down:
	sudo docker compose down

restart:
	sudo docker compose down
	sudo docker compose up -d
