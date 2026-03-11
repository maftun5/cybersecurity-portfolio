# Network Port Scanning and Vulnerability Analysis

> A hands-on cybersecurity project using **Nmap** and a custom Python automation script to detect open ports, enumerate services, and analyze attack surfaces on a Linux host.

---

## 📌 Project Overview

This project demonstrates practical use of **Nmap (Network Mapper)** — the industry-standard open-source tool used by security professionals and penetration testers worldwide. I extended the lab exercise by building a custom Python wrapper (`scan_report.py`) that automates scan execution, parses results, and generates a structured vulnerability report.

**Skills demonstrated:**
- TCP/UDP port scanning and service enumeration
- Version detection and OS fingerprinting
- SSH hostkey extraction via NSE (Nmap Scripting Engine)
- Python scripting for security automation
- Vulnerability research and risk analysis

---

## 🛠️ Tools & Environment

| Tool | Version | Purpose |
|------|---------|---------|
| Nmap | 7.80+ | Port scanning & service detection |
| Python | 3.8+ | Scan automation & report generation |
| Ubuntu Linux | 20.04 | Target environment (VM) |
| VirtualBox | 6.x | Isolated lab environment |

---

## 🧪 Scans Performed

### 1. Basic TCP Scan
```bash
nmap localhost
```
Scans the first **1,000 most common TCP ports** on the loopback interface.

**Results:**
```
PORT     STATE  SERVICE
22/tcp   open   ssh
23/tcp   open   telnet
631/tcp  open   ipp
```

---

### 2. UDP Scan (with sudo)
```bash
sudo nmap -sU localhost
```
UDP scanning requires root privileges. Unlike TCP, UDP has no handshake, so results may show `open|filtered` — meaning the port responded or simply didn't send an ICMP unreachable reply.

**Results:**
```
PORT      STATE           SERVICE
631/udp   open|filtered   ipp
5353/udp  open|filtered   zeroconf
```

---

### 3. Service Version Detection
```bash
nmap -sV localhost
```
The `-sV` flag probes open ports to determine the **exact software version** running — critical for CVE lookups.

**Results:**
```
PORT     STATE  SERVICE  VERSION
22/tcp   open   ssh      OpenSSH 8.2p1 Ubuntu 4ubuntu0.2
23/tcp   open   telnet   Linux telnetd
631/tcp  open   ipp      CUPS 2.3
```

---

### 4. Aggressive Scan + NSE Scripts
```bash
nmap -A localhost
```
`-A` enables OS detection, version detection, script scanning, and traceroute. The NSE `ssh-hostkey` script automatically extracted the host's SSH public keys.

**Captured SSH Hostkeys:**
```
3072 56:68:77:00:41:7f:50:17:5b:73:82:36:47:c4:bc:2d (RSA)
256  0e:52:78:ba:08:2a:df:e5:be:1b:07:a7:98:3a:c8:50  (ECDSA)
256  f7:9e:03:10:96:94:cc:f4:4f:2a:f2:7c:6a:37:c1:6f  (ED25519)
```

---

## 🔐 Vulnerability Analysis

### Port 22 — SSH (OpenSSH 8.2p1)
- **Risk Level:** Medium
- **Why it matters:** SSH is the standard for remote administration. An attacker who obtains valid credentials (via brute force, credential stuffing, or key theft) gains full shell access.
- **Mitigations:** Disable password auth, enforce key-based login, use `fail2ban`, restrict access with firewall rules, disable root login.
- **CVE Note:** OpenSSH 8.2p1 has known vulnerabilities — always patch to the latest stable version.

### Port 23 — Telnet
- **Risk Level:** 🔴 CRITICAL — Should be disabled
- **Why it matters:** Telnet transmits **all data in plaintext**, including usernames and passwords. Any attacker with network access can capture credentials with a packet sniffer like Wireshark.
- **Mitigations:** Disable Telnet completely. Replace with SSH for all remote access.

### Port 631 — CUPS (Internet Printing Protocol)
- **Risk Level:** Low-Medium
- **Why it matters:** CUPS exposes a web interface on port 631. Historically vulnerable to remote code execution (e.g., CVE-2009-3553, CVE-2022-26691).
- **Mitigations:** Disable if printing is not needed. Restrict access to localhost only. Apply patches promptly.

### Port 5353 — mDNS / Zeroconf
- **Risk Level:** Low
- **Why it matters:** Used for local service discovery (Bonjour/Avahi). Can leak information about services on the network.
- **Mitigations:** Disable Avahi if not needed (`sudo systemctl disable avahi-daemon`).

---

## 🤖 Custom Automation Script

I built `scan_report.py` to automate multi-scan execution and output a clean, structured report — simulating what a real security analyst would do after an initial assessment.

→ See [`scan_report.py`](./scan_report.py)

**What it does:**
- Runs TCP, UDP, and version detection scans sequentially
- Parses `nmap -oX` XML output programmatically
- Maps open ports to known CVE risk categories
- Outputs a timestamped Markdown report

---

## 📂 Repository Structure

```
nmap-port-scanner-lab/
├── README.md               ← This file
├── scan_report.py          ← Custom Python automation script
├── sample_output/
│   ├── tcp_scan.txt        ← Raw nmap TCP output
│   ├── udp_scan.txt        ← Raw nmap UDP output
│   └── aggressive_scan.txt ← Raw nmap -A output
└── FINDINGS.md             ← Structured vulnerability findings report
```

---

## 💡 Key Takeaways

1. **Telnet should never be running in production** — it's a plaintext protocol from 1969. Seeing it open is an immediate red flag.
2. **Version detection (`-sV`) is essential** — knowing the exact software version is what enables targeted CVE research.
3. **SSH hostkeys can be fingerprinted remotely** — this can help attackers verify they're connecting to the same host over time (or detect changes in a MITM scenario).
4. **UDP is often overlooked** — requiring `sudo` and returning `open|filtered` makes UDP scanning tedious, which is exactly why attackers and defenders alike tend to miss it.
5. **Automation matters** — real security work involves scanning hundreds or thousands of hosts; scripting the process is a core professional skill.

---

## 📚 References

- [Nmap Official Documentation](https://nmap.org/docs.html)
- [IANA Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers)
- [CVE Database — MITRE](https://cve.mitre.org/)
- [NIST National Vulnerability Database](https://nvd.nist.gov/)
- [OpenSSH Security Advisories](https://www.openssh.com/security.html)

---

*Lab completed in an isolated VirtualBox VM environment. No external systems were scanned.*
