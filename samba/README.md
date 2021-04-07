# samba
simple samba container based on [dperson/samba](https://github.com/dperson/samba)  
it will create two shared folders priv and pub  
* pub is public with read/write access for everyone
* priv is private with read/write access only for authenticated users  
  these two folders will be mounted volumes from the host, so they will survive a restart or removal of the container
* a user with password will be created according to the settings in .env file
#
## Instructions
* clone samba folder to machine:  
```svn checkout https://github.com/trasba/docker-compose-lib/trunk/samba ```  
install subversion (svn) if necessary ```sudo apt install subversion```
* create & adjust .env file from .env.example
* startup container
```docker-compose up -d```