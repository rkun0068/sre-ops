#!/bin/bash
# Define the list of software and their expected versions
declare -A software_versions=(
    [epel-release]="8-18.el8.noarch"
    [rsyslog]="8.2102.0-7.el8_6.1.x86_64"
    [esmtp-local-delivery]="1.2-15.el8.x86_64"
    [libzstd]="1.5.0-1.el7.x86_64"
    [vim-enhanced]="8.0.1763-19.el8_6.4.x86_64"
    [vim-minimal]="8.0.1763-16.el8_5.13.x86_64"
    [sudo]="1.8.29-8.el8.x86_64"
    [telnet]="0.17-76.el8.x86_64"
    [smem]="1.5-6.el8.noarch"
    [htop]="3.2.1-1.el8.x86_64"
    [rsync]="3.1.3-14.el8.x86_64"
    [lsof]="4.93.2-1.el8.x86_64"
    [mtr]="0.92-3.el8.x86_64"
    [mailx]="12.5-29.el8.x86_64"
    [chrony]="4.1-1.el8.x86_64"
    [zip]="3.0-23.el8.x86_64"
    [java-1.8.0-openjdk]="1.8.0.252.b09-2.el7_8.x86_64"
    [java-1.8.0-openjdk-devel]="1.8.0.252.b09-2.el7_8.x86_64"
    [java-1.8.0-openjdk-headless]="1.8.0.252.b09-2.el7_8.x86_64"
    [wget]="1.19.5-10.el8.x86_64"
    [traceroute]="2.1.0-6.el8.x86_64"
    [java-11-openjdk]="11.0.12.0.7-0.el7_9.x86_64"
    [java-11-openjdk-devel]="11.0.12.0.7-0.el7_9.x86_64"
    [java-11-openjdk-headless]="11.0.12.0.7-0.el7_9.x86_64"
    [yum-plugin-priorities]="1.1.31-54.el7_8.noarch"
    [bzip2]="1.0.6-26.el8.x86_64"
    [tar]="1.30-5.el8.x86_64"
    [ice]="1.6.7-1dkms.noarch"
    [nscd]="2.28-211.el8.x86_64"
    [sssd]="2.6.2-3.el8.x86_64"
)

# Check versions
echo "Checking software versions..."
for software in "${!software_versions[@]}"; do
    expected_version=${software_versions[$software]}
    installed_version=$(rpm -q --qf "%{VERSION}-%{RELEASE}.%{ARCH}\n" "$software" 2>/dev/null)

    if [ $? -eq 0 ]; then
        if [ "$installed_version" == "$expected_version" ]; then
            echo "OK: $software is $installed_version (matches expected version)"
        else
            echo "WARNING: $software is $installed_version (expected $expected_version)"
        fi
    else
        echo "ERROR: $software is not installed."
    fi
done
