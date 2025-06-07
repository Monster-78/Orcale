
#!/bin/bash

echo "========================================"
echo "🚀 Monster VPS Setup Script Started 🚀"
echo "========================================"

# Step 1: Update System
echo "🔄 Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

# Step 2: Install Apache, PHP, MySQL Server
echo "📦 Installing Apache, PHP, and MySQL..."
sudo apt install apache2 php php-mysql mysql-server -y

# Step 3: Enable & Start Apache
sudo systemctl enable apache2
sudo systemctl start apache2

# Step 4: Enable & Start MySQL
sudo systemctl enable mysql
sudo systemctl start mysql

# Step 5: Allow Apache through UFW (firewall)
echo "🔓 Allowing Apache on UFW firewall..."
sudo ufw allow 'Apache Full'
sudo ufw --force enable

# Step 6: Setup Website Page
echo "📝 Creating basic index.html page..."
echo "<!DOCTYPE html>
<html>
<head>
  <title>Monster VPS Website</title>
</head>
<body>
  <h1>🚀 Welcome to Monster VPS Hosting! 🔥</h1>
  <p>This site is hosted on your Oracle VPS using Apache Server.</p>
</body>
</html>" | sudo tee /var/www/html/index.html > /dev/null

# Step 7: Show Server IP
IP=$(curl -s ifconfig.me)
echo "🌐 Your website is live at: http://$IP"
echo "💡 Paste this IP in your browser to view your site."

echo "✅ Setup Complete! Enjoy your Monster VPS Hosting!"

