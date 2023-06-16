# Shell-script-WP-website
This Script will check the availability of Docker and Docker-compose in your system if the docker and docker-compose will not present in your system, it will install both of them. then it will take your site name and will create a entry in /etc/hosts which will point site name (example.com) to localhost. and this will create containers of wordpress LEMP stack using docker-compose. if you are using Ubuntu Desktop you can access your website by just hitting the url in your browser. you have the control to delete or disable your website by just re-run the script in disable or delete mode.
## This script basically take 2 command line arguments 
- first is site name 
   eg: example.com
- second is the Action you want to perform (enable, delete, disable)
   eg: enable
## To run the Script
### Syntax sudo ./script.sh site-name site-action
 ``` sudo chmod +x script.sh
     sudo ./script.sh example.com enable
     ```
