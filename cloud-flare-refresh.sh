#!/bin/bash

# Generate a new random user identifier
user_identifier=$(uuidgen)

# Store the current IP address configuration
current_ip=$(ifconfig eno1 | awk '/inet / {print $2}')

# Display the current IP address
echo "Current IP address: $current_ip"

# Uncomment the following line if you want to use DHCP for dynamic IP assignment
# sudo dhclient eno1

# Uncomment the following line if you want to manually assign a new IP address
# sudo ifconfig eno1 NEW_IP_ADDRESS

# Display the new IP address
new_ip=$(ifconfig eno1 | awk '/inet / {print $2}')
echo "New IP address: $new_ip"

# Restart the network interface
sudo ifdown eno1 && sudo ifup eno1

# Check if Cloudflare WARP is installed before attempting to remove it
if dpkg -l | grep -q cloudflare-warp; then
    # Uninstall Cloudflare WARP
    sudo apt-get remove --purge cloudflare-warp

    # Remove Cloudflare WARP repository
    sudo rm /etc/apt/sources.list.d/cloudflare-client.list

    # Add Cloudflare GPG key
    curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

    # Add Cloudflare repo to apt repositories
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

    # Update and install Cloudflare WARP
    sudo apt-get update && sudo apt-get install cloudflare-warp

    # Create the directory and configuration file if they don't exist
    sudo mkdir -p /etc/warp-client
    sudo touch /etc/warp-client/warp-client.toml

    # Set the user identifier in the Cloudflare configuration file
    sudo bash -c "echo 'user-id = \"$user_identifier\"' >> /etc/warp-client/warp-client.toml"

    # Register and connect to Cloudflare WARP
    warp-cli register
    warp-cli connect

    # Set WARP mode and families mode
    warp-cli set-mode warp+doh
    warp-cli set-families-mode malware
fi

# Display WARP connection information
curl https://www.cloudflare.com/cdn-cgi/trace/
