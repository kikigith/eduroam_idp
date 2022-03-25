#!/bin/sh

PATH=/opt/sbin:/opt/bin:$PATH
export PATH


sed -i -e "s/DB_DIALECT/$DB_DIALECT/"   /opt/etc/raddb/mods-enabled/sql
sed -i -e "s/DB_HOST/$DB_HOST/"   /opt/etc/raddb/mods-enabled/sql
sed -i -e "s/DB_PORT/$DB_PORT/"   /opt/etc/raddb/mods-enabled/sql
sed -i -e "s/DB_NAME/$DB_NAME/"   /opt/etc/raddb/mods-enabled/sql
sed -i -e "s/DB_USER/$DB_USER/"   /opt/etc/raddb/mods-enabled/sql
sed -i -e "s/DB_PASS/$DB_PASS/"   /opt/etc/raddb/mods-enabled/sql
#echo "$(sed -i -e 's/IDP_REALM/$IDP_REALM/'  /opt/etc/raddb/sites-available/eduroam)" > /opt/etc/raddb/sites-available/eduroam

set -e


# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- radiusd "$@"
fi

# check for the expected command
if [ "$1" = 'radiusd' ]; then
    shift
    exec radiusd -f "$@"
fi

# debian people are likely to call "freeradius" as well, so allow that
if [ "$1" = 'freeradius' ]; then
    shift
    exec radiusd -f "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"