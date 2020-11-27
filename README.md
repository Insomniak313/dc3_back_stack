# Thesis Stack

This stack includes :
* a [Traefik](https://docs.traefik.io/v2.0/) reverse proxy (used to bind virtual hosts to each container)
* a [PHP-FPM](https://www.php.net/manual/fr/install.fpm.php) container (PHP7.3)
* a [Nginx](https://www.nginx.com/) proxy (acting as front server)
* a [Node.js](https://nodejs.org/) container (including NPM and Yarn, used to build javascript)
* a [PostgreSQL](https://www.postgresql.org/) container (our database)
* a [Adminer](https://www.adminer.org/) container (PHPMyAdmin-like, to see and interact with the database)
 
## Prerequisites

### Install Docker

First of all, you need to install Docker on your machine

##### Ubuntu

```
sudo apt install docker.io
```

##### OS X

https://docs.docker.com/v17.12/docker-for-mac/install/

##### Windows

https://docs.docker.com/v17.12/docker-for-windows/install/

### Change /etc/hosts file

No changes are needed ! All virtual hosts are handled by Traefik. We furthermore only use <code>\*.localhost</code> as virtual host for our services (<code>\*.localhost</code> host names are systematically redirected to <code>127.0.0.1</code> ).
## Using the stack

### The stack.sh script
A script called "stack.sh" is provided in the root of this directory. 

If it's the first time that you launch the stack, you first need to build it :

```
./stack.sh build
```

Then you can launch the stack, simply type :

```
./stack.sh start
```
To stop it, you can use :

```
./stack.sh stop
```
If this stack evolves, you still can rebuild it with :

```
./stack.sh rebuild
```

### Accessing and interacting with containers
You can access each container using the <code>./stack.sh cli</code> command :

##### For PHP : 
```
./stack.sh cli php
```
You will be then connected as www-data to the PHP container. 

This is where you'll launch your PHP commands (<code>php bin/console ...</code>).
##### For Nginx : 
```
./stack.sh cli nginx
```
You will be connected as root to the Nginx container.

This service can be accessible in the browser at the URL [http://nginx.myproject.localhost](http://nginx.myproject.localhost) : this is the main entry of our app.
##### For Node : 
```
./stack.sh cli node
```
You will be connected as node to the Node container.

This is where you'll launch your JS build commands (<code>yarn ...</code>).

This service can be accessible in the browser at the URL [http://node.myproject.localhost](http://node.myproject.localhost). 
If you access that URL on the port 80, Traefik will redirect you to the Node container on the 8080 port (default webpack-dev-server port, used with Live-Reloading and Hot Module Replacement).
##### For PostgreSQL : 
```
./stack.sh cli db
```
You will be connected as root to the PostgreSQL container.

##### For Adminer : 

The <code>./stack.sh cli adminer</code> command won't work. You can't access the inside of this container. 
However, this service can be accessible in the browser at the URL [http://adminer.myproject.localhost](http://adminer.myproject.localhost).

##### For Traefik : 

The <code>./stack.sh cli traefik</code> command won't work. You can't access the inside of this container. 
However, this service can be accessible in the browser at the URL [http://traefik.myproject.localhost](http://traefik.myproject.localhost).

## What's next ?

You're now ready to install [Thesis repository](https://gitlab.com/finindev/myproject).
 
Place yourself in the app folder :
```
cd volumes/app/
```
You can now clone myproject repository
```
git clone git@gitlab.com:finindev/myproject.git
```
And continue to the other [README](https://gitlab.com/finindev/myproject/-/blob/master/README.md)
