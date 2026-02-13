# Watcher - Network Connection Monitor Helper

This project is PowerShell-based, and it monitors TCP connections and flags those using suspicious ports or originating from potentially malicious processes.

## Features:
- Real-time network monitoring
- Suspicious port detection (for example 4444 - listener port for Metasploit, 6666- kali default port-IRC botnets, etc...)
- Suspicious process detection ( telnet...)
- Console Output
- Forensic logging

## How it Works
1. Executes `netstat -abno` to get current connections
2. Filters to only ESTABLISHED connections
3. Analyzes each for suspicious port and process
4. Outputs on findings
5. Logs to timestamped files

[Script](./Watcher.ps1)

### Screenshot
<img width="765" height="149" alt="image" src="https://github.com/user-attachments/assets/a62260a0-df02-4bb4-b7a9-f92c03b9d01c" />

#### [Output log file](./connections_2026-02-13_19-52.txt)
No suspicious ports or processes
