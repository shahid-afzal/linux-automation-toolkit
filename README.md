# Linux Server Automation Toolkit

This is a collection of Bash scripts I built to automate routine Linux administration, system monitoring, and server maintenance.

Instead of manually SSH-ing into a server to check disk space, clean up old logs, or restart crashed services, this toolkit handles it in the background using `cron`. It is designed with modularity in mind—all alert thresholds are managed in a central configuration file rather than hardcoded into the scripts.

## 🧠 The Architecture Pipeline

The core of this toolkit revolves around an automated observability loop:
`Threshold Crossed  →  Bash Script Logic  →  Log Event  →  Trigger Alert`

## 📂 Repository Structure

```text
linux-automation-toolkit/
├── scripts/
│   ├── alert.sh
│   ├── backup_manager.sh
│   ├── create_user.sh
│   ├── health_check.sh
│   ├── log_manager.sh
│   ├── service_monitor.sh
│   └── temp_cleaner.sh
├── config/
│   └── settings.conf
├── logs/
├── backups/
├── setup.sh
└── README.md
```

## 🛠️ The Scripts: What they do and why

* **`setup.sh`**
  * **What it does:** Bootstraps the environment by creating necessary directories (`logs/`, `backups/`) and making all scripts executable.
  * **Why:** To make the toolkit plug-and-play. You shouldn't have to manually run `chmod +x` a dozen times to get things working.

* **`health_check.sh`**
  * **What it does:** Pulls Uptime, CPU, Memory, and Disk usage. It parses the disk usage into an integer and checks it against a threshold limit.
  * **Why:** To catch storage leaks before the server hits 100% capacity and crashes.

* **`alert.sh`**
  * **What it does:** A master notification script. Other scripts pass string arguments to it (`$1`), which it then logs to `alerts.log` and broadcasts to the terminal.
  * **Why:** Centralizes the alerting logic (DRY principle). If I ever want to swap terminal broadcasts for a Slack Webhook, I only have to update this one file.

* **`service_monitor.sh`**
  * **What it does:** A watchdog script that checks if a critical service (like `cron`) is running. If it's dead, it triggers an alert and automatically forces a restart.
  * **Why:** Self-healing infrastructure. If a service crashes at 3 AM, the script attempts to fix it without human intervention.

* **`backup_manager.sh`**
  * **What it does:** Creates timestamped `.tar.gz` archives of the `/etc` directory (or any directory defined in the config) and stores them in the `backups/` folder.
  * **Why:** Automated disaster recovery for system configurations.

* **`log_manager.sh` & `temp_cleaner.sh`**
  * **What they do:** Compress old `.log` files into `.gz` format, clear out current logs, and purge files in `/tmp` that are older than 7 days.
  * **Why:** Routine garbage collection to prevent log bloat from consuming all available server disk space.

* **`create_user.sh`**
  * **What it does:** Safely provisions new Linux users with a home directory and default bash shell, checking to ensure the user doesn't already exist.

## 🚀 Quick Start

1. Clone the repository to your Linux machine:
```bash
git clone https://github.com/yourusername/linux-automation-toolkit.git
cd linux-automation-toolkit
```

2. Run the bootstrap script to set up directories and permissions:
```bash
./setup.sh
```

3. Open `config/settings.conf` and adjust your thresholds (e.g., `DISK_WARNING_THRESHOLD=80`).

4. Add the scripts to your `crontab` (`crontab -e`) to automate them. Example:
```bash
# Run health check every minute
* * * * * /path/to/toolkit/scripts/health_check.sh

# Rotate logs at midnight
0 0 * * * /path/to/toolkit/scripts/log_manager.sh
```