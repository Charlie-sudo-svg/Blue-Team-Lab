# Setting Up Splunk Alerts

## Failed Login Alerts

I first set up a Splunk Alert for failed logins to potentially detect a brute-force attack. To do this, I indexed `Index="endpoint" AND EventCode=4625` From there I clicked on Save As -> Alert and configured the alert as such:

![Screenshot 2025-02-24 162932](https://github.com/user-attachments/assets/943e03c0-9dcb-472f-a09b-0ccdf59c624d)

I set it up to trigger when 5 or more failed login attempts happen within 1 minute. For a real enterprise though, its more wise to set this value to 25. For the alert to actually work, I needed to set an action with it. I set it up where Splunk emails me everytime the alert is triggered, as shown below.

![Screenshot 2025-02-24 163154](https://github.com/user-attachments/assets/9522e570-268c-455a-bbc6-ddfec4df1101)

