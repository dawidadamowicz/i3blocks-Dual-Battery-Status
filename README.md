# i3blocks Dual Battery Status

A simple script to display the battery percentage and status (charging, discharging, or low battery) in your i3blocks status bar. Supports systems with one or two batteries.

## 🔋 Features

- Interactive button allowing user to check the remaining battery time by left-clicking.
- Displays the combined battery percentage for systems with multiple batteries.
- Shows charging status with an icon (`⚡`).
- Alerts for low battery levels with an icon (`🔋`).
- Works seamlessly with i3blocks on Arch Linux or any Linux distribution using `i3wm`.

## 📋 Prerequisites

- Linux system with `i3wm` and `i3blocks` installed.
- Battery information available under `/sys/class/power_supply/BAT0` and `/sys/class/power_supply/BAT1` (or only `BAT0` for single-battery systems).

## 🛠️ Installation

### 1. Clone the Repository

```bash
git clone https://github.com/dawidadamowicz/i3blocks-dual-battery-status.git
cd i3blocks-dual-battery-status
```

### 2. Install the Script

Copy the `battery_status.sh` script to your i3blocks configuration directory:

```bash
mkdir -p ~/.config/i3blocks
cp battery_status.sh ~/.config/i3blocks/
chmod +x ~/.config/i3blocks/battery_status.sh
```

### 3. Update i3blocks Configuration

Add the following block to your i3blocks configuration file (usually located at `~/.config/i3blocks/config`):

```ini
[battery]
command=~/.config/i3blocks/battery_status.sh
interval=30
```

### 4. Reload i3blocks

Reload i3blocks to apply the changes:

```bash
pkill -SIGRTMIN+10 i3blocks
```

## 🖱️ How It Works

- The script checks the battery status and capacity for `/sys/class/power_supply/BAT0` and `/sys/class/power_supply/BAT1`.
- If multiple batteries are present, it calculates the average percentage.
- Icons are displayed based on the status:
  - `⚡` for charging.
  - `🔋` for low battery (≤20%).
- Outputs the battery percentage and icon in the i3blocks bar.

## Example Output

| Status          | Output     |
|------------------|------------|
| Charging         | ⚡ 65%     |
| Low Battery      | 🔋 18%     |
| Discharging      | 54%       |
| No Battery Found | No battery |
