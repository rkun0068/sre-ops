#!/bin/bash
# Change it based on your system
# Define virtual machine parameters
declare -A VM_PARAMS=(
    ["name"]="rocky8-vm"                          # Name of the VM
    ["memory"]="8192"                             # Memory size in MB
    ["vcpus"]="4"                                 # Number of CPU cores
    ["disk_path"]="/var/lib/libvirt/images/<.qcow2 image>" # Path to your .qcow2 image
    ["os_variant"]="rhel8.0"                      # OS variant for Rocky Linux 8[centos7]
    ["network"]="default"                         # Virtual network
                    # Set to false for .qcow2 usage
)

# Create VM using virt-install
create_vm() {
    echo "Creating virtual machine: ${VM_PARAMS["name"]}"

    # Using existing qcow2 image
    virt-install \
    --name "${VM_PARAMS["name"]}" \
    --ram "${VM_PARAMS["memory"]}" \
    --vcpus "${VM_PARAMS["vcpus"]}" \
    --disk path="${VM_PARAMS["disk_path"]}",bus=virtio \
    --os-variant "${VM_PARAMS["os_variant"]}" \
    --network network="${VM_PARAMS["network"]}",model=virtio \
    --import \
    --graphics none

    echo "Virtual machine created successfully: ${VM_PARAMS["name"]}"
}

# Validate that the qcow2 file exists
validate_params() {
    if [ ! -f "${VM_PARAMS["disk_path"]}" ]; then
        echo "The specified qcow2 image does not exist: ${VM_PARAMS["disk_path"]}"
        exit 1
    fi
}

# Main function
main() {
    validate_params
    create_vm
}

main