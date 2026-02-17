# SQL Injection Forensics Lab

## Overview

This project analyzes a real SQL injection attack captured in a PCAP file. I dissect the attack step-by-step, create detection rules, and demonstrate secure coding practices.

**Based on:** Cisco Cybersecurity Essentials Lab 4.2.8

## What I Learned

- Identify SQL injection attempts in network traffic
- Understand the SQL injection methodology
- Create Wireshark filters to detect SQLi payloads
- Write Snort/Suricata rules for SQLi detection
- Implement parameterized queries to prevent SQLi

## Analysis
I analyzed a pcap file in VM and documented a complete attack

## Detection

I created detection methods:
- **Wireshark Filters**
- **Snort Rules**

[Full here](detection/)

## Prevention Techniques

I demonstrated secure coding with:
- **Parametrized queries** 
- **Input Validation** with regex whitelisting

*Done in Python*

[View Here](prevention/)
