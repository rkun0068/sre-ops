#! /bin/bash

# Define the colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
declare -i ERRORS=0



# Check mount point ssd:/mnt/ssd/<n-1> hdd:/mnt/hdd/<n-1> n is the quantity of ssd or hdd 
check_mount_point(){
    # Get the device name of system disk
    SYSTEM_DISK=$(lsblk -nlo NAME,MOUNTPOINT | grep -w '/' | sed 's/[0-9].*//')
    # Get all info of disks
    disk_info=$(lsblk -d -o NAME,SIZE,ROTA,MOUNTPOINT --noheadings)
    echo -e "${NC}===================="
    echo -e "${YELLOW}System disk: ${NC}${SYSTEM_DISK}"
    echo -e "${YELLOW}Expected format: /mnt/ssd/<n-1> n is the quantity of ssd"
    echo -e "${YELLOW}Expected format: /mnt/disk/<n-1> n is the quantity of hdd"
    echo -e "${NC}===================="
    # Get all info of disks
    while read -r line;do
        device=$(echo $line | awk '{print $1}')
        size=$(echo "$line" | awk '{print $2}')
        rota=$(echo "$line" | awk '{print $3}')
        mount_point=$(echo "$line" | awk '{print $4}')
        # Skip the system disk
        if [ "$device" == "$SYSTEM_DISK" ];then
            continue
        fi
        # If the mount point is empty
        if [ -z "$mount_point" ];then
            echo -e "${RED}Error: ${device} is not mounted"
            ERRORS+=1
            continue
        fi

        # Check the mount point is valid
        if [ "$rota" == "0" ];then
           # SSD disk should be mounted on /mnt/ssd/<n-1>
           if [[ ! "$mount_point" =~ ^/mnt/ssd/[0-9]+$ ]];then
                echo -e "${RED}Error: ${device} has incorrect mount point ${NC}${mount_point}"
                ERRORS+=1
           else
                echo -e "${GREEN}OK: ${device} (SSD) mounted at ${NC}${mount_point}"
           fi
        elif [ "$rota" == "1" ];then
            # HDD disk should be mounted on /mnt/disk/<n-1>
            if [[ ! "$mount_point" =~ ^/mnt/disk/[0-9]+$ ]];then
                echo -e "${RED}Error: ${device} has incorrect mount point ${NC}${mount_point}"
                ERRORS+=1     
            else
                echo -e "${GREEN}OK: ${device} (HDD) mounted at ${NC}${mount_point}"
            fi
        else
            echo -e "${RED}Error: ${device} is unknown type"
            ERRORS+=1        
        fi
    done <<< "$disk_info"
    echo -e "${NC}===================="
    echo -e "${YELLOW}Total errors: ${ERRORS}${NC}"
    if [ $ERRORS -eq 0 ];then 
        echo -e "${GREEN}All mount points are correctly configured${NC}"
        exit 0
    else
        echo -e "${RED}Found errors in mount point configuration${NC}"
        exit 1
    fi

}

echo -e "${NC}Checking mount points..."
check_mount_point

