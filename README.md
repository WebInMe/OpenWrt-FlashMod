# OpenWrt Custom Builds

Automated daily builds of OpenWrt with extended UBI partitions for:
- **Redmi AX6000** (256MB & 512MB UBI variants)
- **Xiaomi AX3000T** (256MB & 512MB UBI variants)

## Features

- ✅ Daily automatic builds when new OpenWrt versions are released
- ✅ Extended UBI partitions (256MB/512MB options)
- ✅ Four build variants for different router/flash combinations
- ✅ Automatic release publishing with all artifacts
- ✅ Workflow cleanup to manage storage

## Build Variants

| Device | Flash Size | UBI Partition | Artifact Name |
|--------|------------|---------------|---------------|
| Redmi AX6000 | 256MB | 256MB | redmi_ax6000_256mb |
| Redmi AX6000 | 512MB | 512MB | redmi_ax6000_512mb |
| Xiaomi AX3000T | 256MB | 256MB | xiaomi_ax3000t_256mb |
| Xiaomi AX3000T | 512MB | 512MB | xiaomi_ax3000t_512mb |

## Usage

### Automatic Builds
The workflow runs daily at midnight UTC and automatically:
1. Checks for new OpenWrt releases via GitHub API
2. Clones the repository at the latest tag
3. Applies DTS patches for extended UBI partitions
4. Builds all four variants
5. Publishes to GitHub Releases

### Manual Trigger
Go to **Actions** → **OpenWrt Auto Build** → **Run workflow**
- Check "Force build" to rebuild even without new versions

## Installation

1. Download the appropriate firmware from [Releases](https://github.com/yourusername/yourrepo/releases)
2. Follow device-specific installation instructions
3. Flash via TFTP or recovery mode

### Redmi AX6000
- TFTP recovery method recommended
- Hold reset button while powering on
- Upload firmware to 192.168.1.1

### Xiaomi AX3000T
- SSH method (if already rooted)
- TFTP recovery method
- Use `mtd write` for flashing

## Technical Details

### DTS Modifications
The UBI partition is extended from the default size to:
- **256MB variant**: `reg = <0x2400000 0x10000000>;`
- **512MB variant**: `reg = <0x2400000 0x20000000>;`

### Partition Layout
