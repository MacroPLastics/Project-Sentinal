#!/bin/bash

#Welcome to the Sentinal Network Scanner (sns for short)
#the next itteration of imp
#focused on modularity and features
#to implement: nmap fping updates install wireshark auto pm detection debugging and maitenance stuff

source snsmaintenance.txt
source snsdebugging.txt
source snsscans.txt
source snswireshark.txt
source snswelcome.txt
source snsdeauth.py

welcome #welcome text from snswelcome.txt

#####menu logic#####

###deauth###

deauth_submenu(){
    echo "Deauth."
        echo "s.    Deauth a specified device"
        echo "a.    Deauth all devices"
        echo "r.    Return to the main menu"
        echo "q.    Quit"

            read -rp ">" deauth_choice
                case $deauth_choice in
                    [Ss])
                        #gets info for the deauth script
			iwlist wlan0 scan | grep Address
                        	read -rp "Enter the target MAC address: " target_mac
                        	read -rp "Enter the AP MAC address: " ap_mac
                        	read -rp "Enter the interface in monitor mode (e.g., wlan0mon): " iface
                    python3 snsdeauth.py device "$ap_mac" "$iface" "$target_mac"
                    ;;
                    [Aa])
                        #Deauth all
			iwlist wlan0 scan | grep Address
                        	read -rp "Enter the AP MAC address: " ap_mac
                        	read -rp "Enter the interface in monitor mode (e.g., wlan0mon): " iface
                            python3 snsdeauth.py all "$ap_mac" "$iface"
                    ;;
                    [Rr])
                        return_to_main_menu
                            return_to_main_menu=false
                    ;;
                    [Qq])
                        echo "Exiting..."
                            exit 0
                    ;;
                    *)
                        echo "Invalid option!"
                            deauth_submenu
                    ;;
                esac
}

###scans###

scans_submenu(){
    echo "Scans."
        echo "d.    Discover live hosts"
        echo "b.    A basic scan on a specified IP"
        echo "a.    An advanced scan on a specified IP"
        echo "u.    The ultimate nmap scan. (Will take a lot of time)"
        echo "f.    A basic scan on all alive IPs"
        echo "c.    An advanced scan on all alive IPs"
        echo "r.    Return to the main menu"
        echo "q.    Quit"

            read -rp ">" scans_choice
                case $scans_choice in
                    [Dd])
                        discover_hosts
                    ;;
                    [Bb])
                        basic_specified_scan
                    ;;
                    [Aa])
                        adv_specified_scan
                    ;;
                    [Uu])
                        ult_specified_scan
                    ;;
                    [Ff])
                        basic_discover_scan
                    ;;
                    [Cc])
                        adv_discover_scan
                    ;;
                    [Rr])
                        return_to_main_menu
                            return_to_main_menu=false
                    ;;
                    [Qq])
                        echo "Exiting..."
                            exit 0
                    ;;
                    *)
                        echo "Invalid option!"
                            scans_submenu
                    ;;
                esac
}


###Wireshark###

wireshark_submenu(){
    echo "Wireshark."
        echo "s.    Start Wireshark"
        echo "r.    Retrun to the Main menu"
        echo "q.    Quit"

            read -rp ">" wirehark_choice
                case $wirehark_choice in
                    [Ss])
                        echo "Starting Wireshark..."
                            start_ws
                    ;;
                    [Rr])
                        return_to_main_menu
                            return_to_main_menu=false
                    ;;
                    [Qq])
                        echo "Exiting..."
                            exit 0
                    ;;
                    *)
                        echo "Invaild option!"
                            wireshark_submenu
                    ;;
                esac
}


###debugging####

debugging_submenu(){
    echo "Debugging."
        echo "i.    Display IP data"
        echo "e.    Enter the editor menu"
        echo "m.    Make the iplist.txt file"
        echo "c.    Create the nmap log dir"
        echo "r.    Return to the Main menu"
        echo "q.    Quit"

            read -rp ">" debugging_choice
                case $debugging_choice in
                    [Ii])
                        ip_data
                    ;;
                    [Ee])
                        edit
                    ;;
                    [Mm])
                        make_iplist
                    ;;
                    [Cc])
                        check_create_log_dir
                    ;;
                    [Rr])
                        return_to_main_menu
                            return_to_main_menu=false
                    ;;
                    [Qq])
                        echo "Exiting..."
                            exit 0
                    ;;
                    *)
                        echo "Invalid option!"
                            debugging_submenu
                    ;;
                esac
}

###maitenance###

maintenance_submenu(){
    echo "maintenance."
        echo "d.    Detect your package manager"
        echo "e.    Echo your package manager"
        echo "u.    Update your package manager"
        echo "i.    Install dependancies"
        echo "c.    Clear the Nmap log dir"
        echo "r.    Return to the main menu"
        echo "q.    Quit"

            read -rp ">" maintenance_choice
                case $maintenance_choice in
                    [Dd])
                        detect_package_manager
                    ;;
                    [Ee])
                        echo_pm
                    ;;
                    [Uu])
                        update_pm
                    ;;
                    [Ii])
                        install_dep
                    ;;
                    [Cc])
                        cleanup_logs
                    ;;
                    [Rr])
                        return_to_main_menu
                            return_to_main_menu=false
                    ;;
                    [Qq])
                        echo "Exiting..."
                            exit 0
                    ;;
                    *)
                        echo "Invalid option!"
                            maintenance_submenu
                    ;;
                esac
}

###main menu logic###

main_menu(){

    local return_to_main_menu=true
        while true; do

            echo "Main Menu."
                echo "1.    Scans"  #add main menu options and make files for scans maintenance debugging useful features wireshark logs etc
                echo "2.    Wireshark"
                echo "3.    debugging"
                echo "4.    maintenance"
		echo "5.    deauth"
                echo "6.    quit"

                read -rp ">" main_menu_choice
                    case $main_menu_choice in
                        1)
                            scans_submenu
                        ;;
                        2)
                            wireshark_submenu
                        ;;
                        3)
                            debugging_submenu
                        ;;
                        4)
                            maintenance_submenu
                        ;;
			5)
			    deauth_submenu
			;;
                        [6Qq])
                            echo "Exiting..."
                                exit 0
                        ;;
                        *)
                            echo "Invalid option!"
                                main_menu
                        ;;
                    esac
                done
}

main_menu


