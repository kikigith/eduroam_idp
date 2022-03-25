###eduroam IdP (Identity Provider) & SP (Service Provider) Docker Image
FreeRADIUS is an open source RADIUS server: http://freeradius.org

This minimal docker image allows to run the current release of FreeRADIUS v3..0.23 that is available in the Alpine Linux distribution.

We use a lightweight alpine docker image as base image


##Environment Variables 
The image uses the environment variables below : 

       - DB_HOST=localhost
       - DB_PORT=5436
       - DB_USER=user
       - DB_NAME=radius
       - DB_DIALECT=postgresql (change to : mysql, ldap to use those drivers instead of postgres)
       - DB_PASS=test 
       - IDP_REALM=institution.tld

##Docker compose
    The IdP+SP requires updates of the proxy.conf and clients.conf files. Just put the updated files in
    the radius directory and restart the service.


##Eduroam
The eduroam setting as recommended in https://wiki.geant.org/display/H2eduroam/freeradius-sp had been 
integrated to sites-available/default server.

##Contributions 
I am opened to any improvement, please share any issue or your contributions with me