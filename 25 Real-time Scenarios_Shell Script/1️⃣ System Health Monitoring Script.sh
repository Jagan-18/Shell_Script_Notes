# System Health Monitoring Script
✅ Monitors CPU, Memory, and Disk Usage
✅ Sends alerts if thresholds are exceeded
---

```bash
#!/bin/bash

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

echo "Checking System Health..."

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}

# Memory Usage (excluding cache)
MEM_USAGE=$(free | awk '/Mem:/ {print ($3-$7)/$2 * 100.0}')
MEM_INT=${MEM_USAGE%.*}

# Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Alerts
if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    echo "⚠️ CPU Usage High: $CPU_INT% | Threshold: $CPU_THRESHOLD%"
fi

if [ "$MEM_INT" -ge "$MEM_THRESHOLD" ]; then
    echo "⚠️ Memory Usage High: $MEM_INT% | Threshold: $MEM_THRESHOLD%"
fi

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "⚠️ Disk Usage High: $DISK_USAGE% | Threshold: $DISK_THRESHOLD%"
fi

echo "System Health Check Completed."
```
---

# Here Explanation of  **System Health Monitoring** script down **step-by-step** so you fully understand what every part is doing.

---
### **1️⃣ Configuration Section**
```bash
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
```

* These are **threshold values** for CPU, memory, and disk usage.
* If usage **≥ threshold**, the script will alert.
* For example:

  * CPU threshold = `80` → alert if CPU usage is **80% or higher**
  * Memory threshold = `80`
  * Disk threshold = `90`

---
### **2️⃣ Start Message**

```bash
echo "Checking System Health..."
```

* Just prints a **status message** so the user knows the check has started.
---
### **3️⃣ CPU Usage Calculation**

```bash
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}
```

* **`top -bn1`** → Runs `top` in **batch mode** (`-b`) for **one iteration** (`-n1`), so it outputs text instead of interactive mode.
* **`grep "Cpu(s)"`** → Finds the line containing CPU stats.
* **`awk '{print 100 - $8}'`** → `$8` is the **idle CPU percentage**.

  * `100 - idle` = actual CPU usage.
  * Example: If idle = `85.5`, usage = `14.5`.
* **`CPU_INT=${CPU_USAGE%.*}`** → Removes decimal point, leaving just the integer part (e.g., `14.5` → `14`), which makes it easier for threshold comparison.

---

### **4️⃣ Memory Usage Calculation**
```bash
MEM_USAGE=$(free | awk '/Mem:/ {print ($3-$7)/$2 * 100.0}')
MEM_INT=${MEM_USAGE%.*}
```

* **`free`** → Shows memory usage in MB.
* **`awk '/Mem:/ ...`** → Finds the line that starts with `Mem:`.
* `$3` = total used memory, `$7` = buffers/cache, `$2` = total memory.
* **`($3 - $7) / $2 * 100.0`** → Gives **real memory usage** percentage, excluding cache (so it’s more accurate than just `$3/$2`).
* Again, we **strip decimals** for easier integer comparison.

---

## **5️⃣ Disk Usage Calculation**

```bash
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
```

* **`df -h /`** → Shows disk usage for `/` in human-readable form (`-h`).
* **`awk 'NR==2 {print $5}'`** → Prints the **5th column** of the **second line** (which contains the usage percentage for `/`).
* **`sed 's/%//'`** → Removes the `%` sign so it’s just a number.

---

### **6️⃣ Alert Checks**

```bash
if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    echo "⚠️ CPU Usage High: $CPU_INT% | Threshold: $CPU_THRESHOLD%"
fi
```

* `if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]` → Checks if CPU usage is **greater than or equal** to the threshold.
* If yes → prints a warning message.

The **same logic** is applied to:

* Memory check:

```bash
if [ "$MEM_INT" -ge "$MEM_THRESHOLD" ]; then
```

* Disk check:

```bash
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
```

---

## **7️⃣ End Message**

```bash
echo "System Health Check Completed."
```

* Just lets the user know the script has finished running.

---

## **8️⃣ How the Script Works in Practice**

* You run it manually or set it in **cron** to run every few minutes.
* It **checks system stats**.
* If **any usage exceeds thresholds**, it **prints an alert** (you can also extend it to send email or save logs).

---

✅ **Example Run Output:**

```
Checking System Health...
⚠️ CPU Usage High: 85% | Threshold: 80%
⚠️ Disk Usage High: 91% | Threshold: 90%
System Health Check Completed.
```

---
--- ### **9️⃣ Optional Enhancements**

# Got it ✅ — I’ll upgrade your script so it not only checks CPU, memory, and disk usage, but also:
# 1. **Logs every check** to a file (so you can review history).
# 2. **Sends email alerts** when thresholds are exceeded.

---

## **Enhanced System Health Monitor**

```bash
#!/bin/bash

# ===== CONFIGURATION =====
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="/var/log/system_health.log"
ALERT_EMAIL="you@example.com"  # Change to your email

# ===== FUNCTION: Log and Send Alerts =====
send_alert() {
    local message="$1"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Log the alert
    echo "$timestamp - ALERT: $message" >> "$LOG_FILE"

    # Send email (requires mail command installed & configured)
    if command -v mail >/dev/null 2>&1; then
        echo "$message" | mail -s "System Health Alert" "$ALERT_EMAIL"
    else
        echo "⚠️ mail command not found — email alert not sent."
    fi
}

# ===== START CHECK =====
echo "Checking System Health..."
echo "---- $(date +"%Y-%m-%d %H:%M:%S") ----" >> "$LOG_FILE"

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}
echo "CPU Usage: $CPU_INT%" >> "$LOG_FILE"

if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
    send_alert "CPU usage is at ${CPU_INT}% (Threshold: ${CPU_THRESHOLD}%)"
fi

# Memory Usage (excluding cache)
MEM_USAGE=$(free | awk '/Mem:/ {print ($3-$7)/$2 * 100.0}')
MEM_INT=${MEM_USAGE%.*}
echo "Memory Usage: $MEM_INT%" >> "$LOG_FILE"

if [ "$MEM_INT" -ge "$MEM_THRESHOLD" ]; then
    send_alert "Memory usage is at ${MEM_INT}% (Threshold: ${MEM_THRESHOLD}%)"
fi

# Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $DISK_USAGE%" >> "$LOG_FILE"

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    send_alert "Disk usage is at ${DISK_USAGE}% (Threshold: ${DISK_THRESHOLD}%)"
fi

echo "System Health Check Completed."
echo "" >> "$LOG_FILE"
```

---

### **How This Works**

1. **Logs everything**

   * Writes CPU, memory, and disk usage to `/var/log/system_health.log`.
   * If thresholds are exceeded, writes an **ALERT** entry.

2. **Email Alerts**

   * Uses `mail` command to send an email to `$ALERT_EMAIL`.
   * Make sure `mailutils` or `sendmail` is installed:

     ```bash
     sudo apt install mailutils     # For Ubuntu/Debian
     sudo yum install mailx         # For RHEL/CentOS
     ```

3. **Cron Job** (for automation)
   Run every 5 minutes:

   ```bash
   */5 * * * * /path/to/system_health.sh
   ```

---

### **Example Log File** (`/var/log/system_health.log`)

```
---- 2025-08-06 15:30:01 ----
CPU Usage: 65%
Memory Usage: 72%
Disk Usage: 88%

---- 2025-08-06 15:35:01 ----
CPU Usage: 85%
Memory Usage: 81%
Disk Usage: 92%
2025-08-06 15:35:01 - ALERT: CPU usage is at 85% (Threshold: 80%)
2025-08-06 15:35:01 - ALERT: Memory usage is at 81% (Threshold: 80%)
2025-08-06 15:35:01 - ALERT: Disk usage is at 92% (Threshold: 90%)
```

---


