# Cloud-flare-identity-changer-

This Bash script performs the following tasks:

Generates a new random user identifier using the uuidgen command.
Stores the current IP address configuration of the network interface "eno1" in the variable current_ip.
Displays the current IP address.
Optionally, enables DHCP for dynamic IP assignment by uncommenting a line and using sudo dhclient eno1.
Optionally, allows for the manual assignment of a new IP address by uncommenting a line and using sudo ifconfig eno1 NEW_IP_ADDRESS.
Displays the new IP address after changes.
Restarts the network interface "eno1" using sudo ifdown eno1 && sudo ifup eno1.
Checks if Cloudflare WARP is installed by searching for the package using dpkg -l.
If Cloudflare WARP is installed, it performs the following actions:
Uninstalls Cloudflare WARP using sudo apt-get remove --purge cloudflare-warp.
Removes the Cloudflare WARP repository.
Adds the Cloudflare GPG key and repository back.
Updates and installs Cloudflare WARP.
Creates a directory and an empty configuration file if they don't exist.
Sets the user identifier in the Cloudflare configuration file.
Registers and connects to Cloudflare WARP using warp-cli.
Sets WARP mode to "warp+doh" and families mode to "malware."
Displays information about the Cloudflare WARP connection.
