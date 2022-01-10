### Starting app interactive:
docker-compose run app /bin/bash

### Execute interactive terminal in running container
docker-compose exec app /bin/bash

### Get the rights back
sudo chown -R $(id -u) .