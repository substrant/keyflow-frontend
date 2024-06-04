cd /srv/frontend
git pull \
    || { echo "Git pull failed!"; exit 1; }
env TARGET=prod docker compose up --build --force-recreate -d \
    || { echo "Docker Compose failed!"; exit 1; }