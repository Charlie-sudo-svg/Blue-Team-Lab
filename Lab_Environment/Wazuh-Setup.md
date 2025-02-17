# Wazuh Setup

I used the Wazuh Quick Start documentation to install Wazuh -> https://documentation.wazuh.com/current/quickstart.html

To install the agent I followed the GUI on the Kali Linux machine:

![Screenshot 2025-02-16 200135](https://github.com/user-attachments/assets/83d49cf5-7800-4e60-9b2d-d41180adb7d1)

After Installing the agent the telemetry was already starting to feed into the server and I was able to generate sample login telemetry on the Windows 10 endpoint. I also took a look at the configuration assessment which assessed over 260 failed security practices

![Screenshot 2025-02-16 195833](https://github.com/user-attachments/assets/dc23f8cc-79b7-4d35-91c1-35ef1742417d)

Looking through these quite a few were false positives or not notable but the ones that are notable will be addressed in ````Blue-Team-Lab/Documentation/Security-Improvements.md````
