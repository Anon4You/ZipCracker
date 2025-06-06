#!/usr/bin/env bash

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Banner
show_banner() {
  echo -e "${GREEN}"
  echo -e "   ▀▀▌▗    ▞▀▖         ▌        "
  echo -e "    ▞ ▄ ▛▀▖▌  ▙▀▖▝▀▖▞▀▖▌▗▘▞▀▖▙▀▖"
  echo -e "   ▞  ▐ ▙▄▘▌ ▖▌  ▞▀▌▌ ▖▛▚ ▛▀ ▌  "
  echo -e "   ▀▀▘▀▘▌  ▝▀ ▘  ▝▀▘▝▀ ▘ ▘▝▀▘▘  "
  echo -e "${NC}"
  echo -e "${PURPLE}=============================================${NC}"
  echo -e "${CYAN}           ZIP Password Cracker${NC}"
  echo -e "${PURPLE}=============================================${NC}"
  echo -e "${YELLOW}          Created by Alienkrishn${NC}"
  echo -e "${BLUE}       GitHub: github.com/Anon4You${NC}"
  echo -e "${PURPLE}=============================================${NC}\n"
}

# Help menu
show_help() {
  show_banner
  echo -e "${YELLOW}Usage:${NC}"
  echo -e "  $0 <zip_file> [wordlist]"
  echo -e "\n${YELLOW}Options:${NC}"
  echo -e "  <zip_file>    Path to password protected ZIP file (required)"
  echo -e "  [wordlist]    Path to wordlist file (default: password.txt)"
  echo -e "\n${YELLOW}Examples:${NC}"
  echo -e "  $0 secret.zip passwords.txt"
  echo -e "  $0 secret.zip (uses default password.txt)"
  exit 1
}

# Main cracking function
crack_zip() {
  local zip_file=$1
  local wordlist=$2

  total_passwords=$(wc -l < "$wordlist")
  current_password=0
  found=0

  echo -e "\n${GREEN}[+] Starting attack on: $zip_file${NC}"
  echo -e "${YELLOW}[i] Using wordlist: $wordlist${NC}"
  echo -e "${YELLOW}[i] Total passwords to try: $total_passwords${NC}"
  echo -e "${PURPLE}=============================================${NC}"

  start_time=$(date +%s)
  
  while IFS= read -r password || [ -n "$password" ]; do
    current_password=$((current_password + 1))
    percentage=$((current_password * 100 / total_passwords))
    
    # Progress bar
    printf "\r${CYAN}[${BLUE}"
    for ((i=0; i<percentage/2; i++)); do printf "■"; done
    printf "${CYAN}] ${percentage}%% ${YELLOW}Trying: '${password}'${NC}"
    
    # Create temp file for password
    tmp_pass=$(mktemp)
    echo "$password" > "$tmp_pass"
    
    if unzip -t -P "$(cat "$tmp_pass")" "$zip_file" >/dev/null 2>&1; then
      rm "$tmp_pass"
      found=1
      end_time=$(date +%s)
      duration=$((end_time - start_time))
      echo -e "\n\n${GREEN}[✓] PASSWORD FOUND: '${password}'${NC}"
      echo -e "${GREEN}[✓] Time taken: ${duration} seconds${NC}"
      echo -e "${GREEN}[✓] Attempts: ${current_password}/${total_passwords}${NC}"
      echo -e "${PURPLE}=============================================${NC}"
      break
    fi
    rm "$tmp_pass"
  done < "$wordlist"

  if [ $found -eq 0 ]; then
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    echo -e "\n\n${RED}[✗] PASSWORD NOT FOUND IN WORDLIST${NC}"
    echo -e "${YELLOW}[i] Time taken: ${duration} seconds${NC}"
    echo -e "${YELLOW}[i] Total attempts: ${current_password}${NC}"
    echo -e "${PURPLE}=============================================${NC}"
    exit 1
  fi
}

# Main execution
main() {
  # Check for minimum arguments
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    show_help
  fi

  zip_file="$1"
  wordlist="${2:-password.txt}" # Default to password.txt if not specified

  # Validate files
  if [ ! -f "$zip_file" ]; then
    echo -e "${RED}[!] ZIP file not found: $zip_file${NC}"
    show_help
  fi

  if [ ! -f "$wordlist" ]; then
    echo -e "${RED}[!] Wordlist not found: $wordlist${NC}"
    show_help
  fi

  show_banner
  crack_zip "$zip_file" "$wordlist"
}

main "$@"
