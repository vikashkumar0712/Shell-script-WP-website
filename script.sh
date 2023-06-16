#!/bin/bash

# Function to check if a command is available
Is_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Checking if the docker and docker-compose is available or not, if not then install
check_install_docker() {
  if ! Is_exists docker || ! Is_exists docker-compose; then
    echo "Docker and Docker Compose are not installed. Installing Docker and Docker Compose..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker "$(whoami)"
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo apt-get install -y docker-compose
    echo "Docker and Docker Compose installed successfully."
  fi
}

# Create a WordPress site using the latest version
create_wordpress_site() {
  if [ -z "$1" ]; then
    echo "Please provide a site name while running the script."
    exit 1
  fi

  site_name="$1"

  # Create docker-compose.yml file
  cat >docker-compose.yml <<EOL
version: '3'
services:
  db:
    image: mysql:latest
    environment:
      MYSQL_DATABASE: test-db
      MYSQL_USER: wp-test-user
      MYSQL_PASSWORD: wptest@123
      MYSQL_ROOT_PASSWORD: rootpassword
    volumes:
      - db_data:/var/lib/mysql
  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - 80:80
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wp-test-user
      WORDPRESS_DB_PASSWORD: wptest@123
volumes:
  db_data:
EOL

  # Create /etc/hosts entry
  echo "127.0.0.1 $site_name" | sudo tee -a /etc/hosts >/dev/null

  # Start containers
  docker-compose up -d

  echo "WordPress site '$site_name' created successfully."

  # Prompt user to open the site in a browser
    sudo apt-get install -y xdg-utils
    read -p "Press Enter to open http://$site_name in your browser..."
    xdg-open "http://$site_name"
}

# Main script
# Enable the WordPress site (start containers)
enable_site() {
  docker-compose up -d
  echo "WordPress site enabled."
}

# Disable the WordPress site (stop containers)
disable_site() {
  docker-compose down
  echo "WordPress site disabled."
}

# Delete the WordPress site (stop containers and remove files)
delete_site() {
  docker-compose down
  sudo rm -rf db_data
  echo "WordPress site deleted."
}
# Check if docker and docker-compose are installed, and install if missing
check_install_docker

# Create a WordPress site with the site name provided as a command-line argument
create_wordpress_site "$1"

Site_State=$2

if [[ $Site_State == "enable" ]]; then
    enable_site
elif [[ $Site_State == "disable" ]]; then
    disable_site
elif [[ $Site_State == "delete" ]]; then
    delete_site
else
    echo "Please enter a valid value from enable, disable, or delete"
fi
