# Sysmon Configuration 

Using Sysmon 15.15v I installed the zip onto the system and unzipped it. I then went into command prompt as administrator and wrote the following commands:

```` Sysmon64.exe -i sysmonconfig-export.xml ````

This starts Sysmon with the configuration file I provided it with. Although I didn't create the config file myself I used SwiftOnSecurity's Sysmon configuration file which is linked right here -> https://github.com/SwiftOnSecurity/sysmon-config/blob/master/sysmonconfig-export.xml

After starting sysmon I went to Applications and Services Logs/Microsoft/Windows/Sysmon/Operational on Windows Event Viewer as an administrator to make sure Sysmon was actually working. To do this I downloaded Sysmon again and it got logged in the Windows Event Viewer below

![Screenshot 2025-02-13 230101](https://github.com/user-attachments/assets/12786ffd-cbab-4dce-98c4-85233b1cf091)



# Conclusion 
After successfuly setting up Sysmon with a configuration file and confirming it works, the next step is to set up a SIEM like Splunk to log this incoming data so analysts can analyze any anomolies and remediate any issues.

This will be helpful later on as we will be testing some penetration techniques against this machine.
