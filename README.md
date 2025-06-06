# ZIP Password Cracker Tool

## Description

A powerful yet simple ZIP archive password recovery tool designed for Termux and Linux systems. This tool brute-forces password-protected ZIP files using a wordlist approach with visual feedback.

## Features

- 🚀 Fast password cracking with progress visualization
- 🎨 Colorful terminal interface with ASCII art banner
- ⏱️ Time tracking and attempt counting
- 📁 Default wordlist support (`password.txt`)
- ✅ Handles passwords containing spaces and special characters
- 📊 Real-time progress bar with percentage
- 🔍 Detailed attempt information

## Installation

1. Clone the repository or download the script:
```bash
git clone https://github.com/Anon4You/ZipCracker.git
cd ZipCracker
```

2. Make the script executable:
```bash
chmod +x zipcracker.sh
```

## Usage

### Basic Syntax
```bash
./zipcracker.sh <zip_file> [wordlist]
```

### Examples

1. With custom wordlist:
```bash
./zipcracker.sh secret.zip my_wordlist.txt
```

2. With default wordlist (password.txt):
```bash
./zipcracker.sh secret.zip
```

3. Show help menu:
```bash
./zipcracker.sh
```

## Requirements

- Termux or Linux environment
- `unzip` package installed
- Bash shell

For Termux users, install dependencies with:
```bash
apt install unzip
```

## Wordlist Tips

1. Create your own wordlist:
```bash
crunch 6 8 1234567890 -o wordlist.txt
```

2. Popular wordlists:
- [rockyou.txt](https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt)
- [SecLists](https://github.com/danielmiessler/SecLists)

## Disclaimer

This tool is for educational and legitimate password recovery purposes only. The creator is not responsible for any misuse of this software.

## License

MIT License

## Credits

Created by [Alienkrishn](https://github.com/Anon4You)

---

For feature requests or bug reports, please open an issue on [GitHub](https://github.com/Anon4You/ZipCracker/issues).