# 🌐 Network Security Configuration - pfSense Firewall

## 1. Login to pfSense Web GUI

Open a web browser and navigate to https://192.168.1.1

Login with the default credentials:

Username: admin  
Password: pfsense  
I changed the default password immediately!

## 2. Configure Interfaces

Go to Interfaces > Assignments and set up the LAN and WAN interfaces:
WAN: DHCP (for internet access)
LAN: Static IP (192.168.1.1/24)

### 🔥 Firewall Rules Table  

| Rule Name             | Source      | Destination | Action | Description |
|----------------------|------------|------------|--------|-------------|
| Allow LAN to Internet | LAN net    | Any        | ✅ Allow | Allows internal devices internet access |
| Block SMB on WAN     | Any        | Any (port 445) | ❌ Block | Prevents SMB exploitation from outside |
| Allow Admin Access   | Admin VLAN | pfSense    | ✅ Allow | Allows admins to manage the firewall |
| Deny All Default     | Any        | Any        | ❌ Block | Blocks all unspecified traffic |


