#!/bin/bash

while true; do
  # Check for new USB drives
  new_drive=$(lsblk -lnp | grep -v "/" | grep "usb" | awk '{print $1}')

  # Mount the new drive if one was found
  if [ -n "$new_drive" ]; then
    echo "Mounting new USB drive $new_drive"
    sudo mount /dev/$new_drive /mnt/usb

    # Search for audio files on the drive
    audio_files=$(find /mnt/usb -maxdepth 1 -name "*.mp3" -o -name "*.wav")

    # Play audio files if any were found
    if [ -n "$audio_files" ]; then
      echo "Playing audio files $audio_files"
      mpg123 $audio_files
    else
      echo "No audio files found on USB drive"
    fi

    # Unmount the drive
    echo "Unmounting USB drive $new_drive"
    sudo umount /mnt/usb
  fi

  # Sleep for a few seconds before checking for new drives again
  sleep 5
done
