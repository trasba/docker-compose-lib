# dashy

A self-hostable personal dashboard built for you. Includes status-checking, widgets, themes, icon packs, a UI editor and tons more!  
 [github](https://github.com/Lissy93/dashy)

## Instructions

- clone dashy folder to machine:  
  `svn checkout https://github.com/trasba/docker-compose-lib/trunk/dashy `  
  install subversion (svn) if necessary `sudo apt install subversion`
- create folder ~/.trasba/docker/dashy
- create ~/.trasba/docker/dashy/conf.yml  
  eiter leave empty to start fresh or copy included conf.yml
- create & adjust .env file from .env.example
- startup container
  `docker-compose up -d`
- dashboard will be available under [localhost:4000](localhost:4000)
