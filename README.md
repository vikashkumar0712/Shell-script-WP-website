## Shell-script-WP-website

This script checks the availability of Docker and Docker Compose on your system. If they are not present, it will install both. Next, it will take your site name and creates an entry in the /etc/hosts file, pointing the site name (example.com) to localhost. The script then creates containers for a WordPress LEMP stack using Docker Compose.

If you're using Ubuntu Desktop, accessing your website is as simple as entering the URL in your browser. You have the control to delete or disable your website by running the script again in either disable or delete mode.
## This script basically take 2 command line arguments 
- first is site name 
   eg: example.com
- second is the Action you want to perform (enable, delete, disable)
   eg: enable
## To run the Script
   Syntax
 ```
   sudo ./script.sh site-name site-action
 ```
   Run These commands
 ```
     sudo chmod +x script.sh
     sudo ./script.sh example.com enable
 ```
