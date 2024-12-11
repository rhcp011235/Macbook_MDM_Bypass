#!/bin/bash

# Define color codes
RED='\033[1;31m'
GRN='\033[1;32m'
BLU='\033[1;34m'
YEL='\033[1;33m'
PUR='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m'

# Function to check serial number via API and authorization status
check_serial_number() {
    serialNumber=$(ioreg -l | grep IOPlatformSerialNumber | awk '{print $4}' | tr -d \")
    if [ -z "$serialNumber" ]; then
        echo -e "${RED}Failed to retrieve the serial number.${NC}"
        return 1
    fi
    
    echo -e "Serial number: ${BLU}$serialNumber${NC}"
}

# Function to check hardware information
check_hardware_info() {
    echo -e "${BLU}Checking Hardware Information...${BLU}"
    
    # Get model name, model identifier, and UDID
    model_name=$(sysctl -n hw.model)
    model_identifier=$(sysctl -n hw.model)
    udid=$(ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { print $3 }' | tr -d '"')

    # Print the hardware information
    echo "Model Name: $model_name"
    echo "UDID: $udid"

}

# Function to create a temporary user
create_temporary_user() {
    read -p "Enter Temporary Fullname (Default is 'Apple'): " realName
    realName="${realName:=Apple}"
    read -p "Enter Temporary Username (Default is 'Apple'): " username
    username="${username:=Apple}"
    read -p "Enter Temporary Password (Default is '1234'): " passw
    passw="${passw:=1234}"

    dscl_path='/Volumes/Data/private/var/db/dslocal/nodes/Default'
    echo -e "${GRN}Creating Temporary User${NC}"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UserShell "/bin/zsh"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UniqueID "501"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" PrimaryGroupID "20"
    mkdir "/Volumes/Data/Users/$username"
    dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" NFSHomeDirectory "/Users/$username"
    dscl -f "$dscl_path" localhost -passwd "/Local/Default/Users/$username" "$passw"
    dscl -f "$dscl_path" localhost -append "/Local/Default/Groups/admin" GroupMembership $username
}

# Function to block MDM domains
block_mdm_domains() {
    echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
    echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
    echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
    echo -e "${GRN}Successfully blocked MDM & Profile Domains${NC}"
}

# Function to remove configuration profiles
remove_configuration_profiles() {
    touch /Volumes/Data/private/var/db/.AppleSetupDone
    rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
    rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
    touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
    touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
}

# Display header
display_header() {
    echo -e "${GRN}╭──────────────────────────────────────────────╮${NC}"
    echo -e "${GRN}│        mDm M1-M2-M3 2024                     │${NC}"
    echo -e "${GRN}│      twitter: john011235                     │${NC}"
    echo -e "${GRN}│      Telagram: john011235                    │${NC}"
    echo -e "${GRN}╰──────────────────────────────────────────────╯${NC}"
    echo ""  # Add a blank line for separation
}

# Main function
main() {
    display_header

    # Check Hardware Information
    check_hardware_info

    # Check Serial Number
    echo -e "${BLU}Checking Serial Number...${NC}"
    check_serial_number

    # Prompt user for choice
    PS3='Please enter your choice: '
    options=("Bypass mDm M1 M2 M3 from Recovery" "Reboot & Exit")
    select opt in "${options[@]}"; do
        case $opt in
            "Bypass mDm M1 M2 M3 from Recovery")
                    echo -e "${YEL}Bypass mDm M1 M2 M3 from Recovery${NC}"
                    if [ -d "/Volumes/Macintosh HD - Data" ]; then
                        diskutil rename "Macintosh HD - Data" "Data"
                    fi
                    create_temporary_user
                    block_mdm_domains
                    remove_configuration_profiles

                    echo -e "${GRN}MDM enrollment has been bypassed!${NC}"
                    echo -e "${NC}Exit terminal and reboot your Mac.${NC}"
                ;;
            "Reboot & Exit")
                echo "Rebooting..."
                reboot
                ;;
            *) echo "Invalid option $REPLY" ;;
        esac
    done
}

# Execute main function
main

