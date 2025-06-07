#!/bin/bash

# Dream Hosting Auto Script - by Dream for Monster 🚀
# Auto install CyberPanel + WordPress + SSL with Domain on Ubuntu 22.04

clear
echo "🌐 Dream Auto Installer for CyberPanel + WordPress"
echo "🔒 Please wait... Installing dependencies"

# Step 1: System update
sudo apt update && sudo apt upgrade -y

# Step 2: Install CyberPanel
echo "⚙️ Installing CyberPanel (this may take 10-15 minutes)..."
cd /root
sudo apt install -y wget
wget -O installer.sh https://cyberpanel.net/install.sh
chmod +x installer.sh
yes | sudo ./installer.sh

# Step 3: Configure Firewall
echo "🛡️ Configuring firewall..."
sudo ufw allow 8090/tcp
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Step 4: Ask for domain
echo -e "\n🌍 Enter your domain (example: grabofy.in):"
read DOMAIN

# Step 5: Setup DNS Reminder
echo -e "\n📌 Please make sure you've pointed A record for $DOMAIN and www.$DOMAIN to this server's IP in Cloudflare or domain panel."
read -p "✔️ Press Enter to continue after pointing A records..."

# Step 6: Install WordPress via CyberPanel CLI
echo -e "\n🧱 Installing WordPress on domain $DOMAIN"
SITE_PASS=$(openssl rand -base64 12)
ADMIN_PASS=$(openssl rand -base64 12)

cyberpanel createWebsite --package Default --domainName "$DOMAIN" --owner admin --email admin@$DOMAIN --php 8.1 --ssl
cyberpanel createFTP --domainName "$DOMAIN" --ftpUser "$DOMAIN" --ftpPassword "$SITE_PASS"
cyberpanel installWordPress --domainName "$DOMAIN" --path /home/$DOMAIN/public_html --wpUser admin --wpPass "$ADMIN_PASS" --wpEmail admin@$DOMAIN

# Step 7: Final Output
echo -e "\n✅ INSTALLATION COMPLETED!"
echo -e "🌐 Website: https://$DOMAIN"
echo -e "🔐 WordPress Login: https://$DOMAIN/wp-admin"
echo -e "     ➤ Username: admin"
echo -e "     ➤ Password: $ADMIN_PASS"
echo -e "🛠️  CyberPanel Login: https://$DOMAIN:8090"
echo -e "     ➤ Username: admin"
echo -e "     ➤ Password: 1234567 (default - change after login)"
echo -e "\n📌 FTP User: $DOMAIN"
echo -e "🔑 FTP Password: $SITE_PASS"
echo -e "\n🚀 Dream script completed successfully for Monster 💖"
