#!/bin/bash

# A very basic shell wrapper as an example to show how to execute the CLI. NB! It has to be run as root.
in_iso_fn="$1"
out_dev_fn="$2"

########################
## WoeUSB CLI arguments
##
# Module termcolor is not installed, text coloring disabled
# usage: woeusb [-h] [--device] [--partition] [--verbose] [--version] [--about]
#               [--no-color] [--debug] [--label LABEL]
#               [--workaround-bios-boot-flag] [--workaround-skip-grub]
#               [--target-filesystem {FAT,NTFS}]
#               source target
# 
# WoeUSB can create a bootable Microsoft Windows(R) USB storage device from an
# existing Windows optical disk or an ISO disk image.
# 
# positional arguments:
#   source                Source
#   target                Target
# 
# optional arguments:
#   -h, --help            show this help message and exit
#   --device, -d          Completely WIPE the entire USB storage device, then
#                         build a bootable Windows USB device from scratch.
#   --partition, -p       Copy Windows files to an existing partition of a USB
#                         storage device and make it bootable. This allows files
#                         to coexist as long as no filename conflict exists.
#   --verbose, -v         Verbose mode
#   --version, -V         Print application version
#   --about, -ab          Show info about this application
#   --no-color            Disable message coloring
#   --debug               Enable script debugging
#   --label LABEL, -l LABEL
#                         Specify label for the newly created file system in
#                         --device creation method
#   --workaround-bios-boot-flag
#                         Workaround BIOS bug that won't include the device in
#                         boot menu if non of the partition's boot flag is
#                         toggled
#   --workaround-skip-grub
#                         This will skip the legacy grub bootloader creation
#                         step.
#   --target-filesystem {FAT,NTFS}, --tgt-fs {FAT,NTFS}
#                         Specify the filesystem to use as the target
#                         partition's filesystem.

if [ -z "${in_iso_fn}" ] || [ -z "${out_dev_fn}" ]; then
    PYTHONPATH="$(pwd):$PYTHONPATH" python3 WoeUSB/woeusb --help
else
    PYTHONPATH="$(pwd):$PYTHONPATH" python3 WoeUSB/woeusb --device -v --no-color --label win10boot --target-filesystem NTFS "${in_iso_fn}" "${out_dev_fn}"
fi

