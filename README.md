# Cloud-flare-identity-changer-


This Bash script accomplishes the following tasks:

1. Generates a random user identifier.
2. Retrieves and displays the current IP address of the network interface "eno1."
3. Optionally configures DHCP for dynamic IP assignment or manually assigns a new IP address.
4. Displays the updated IP address.
5. Restarts the "eno1" network interface.
6.Checks if Cloudflare WARP is installed.
7. If Cloudflare WARP is installed, it:Uninstalls Cloudflare WARP.
8. Removes and reinstalls the Cloudflare repository.
9. Updates and installs Cloudflare WARP.
10. Ensures the existence of a directory and an empty configuration file.
11. Sets the user identifier in the Cloudflare configuration.
12. Registers and connects to Cloudflare WARP using warp-cli.
13. Configures WARP mode to "warp+doh" and families mode to "malware."
14. Displays information about the Cloudflare WARP connection.
