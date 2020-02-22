# Allow ssh from local network
ufw allow proto tcp from 192.168.0.0/16 to any port 22

# Allow specific port from local network
ufw allow from 192.168.0.0/16 to any port 9000

# Public services
ufw allow 80
ufw allow 443

# Describe configuration
ufw status numbered

# Removing a rule
ufw delete 1