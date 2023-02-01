echo "USB player program starts." >> play.log
while true; do
  # Check for new USB drives
  new_drive=$(ls /dev/ | grep "sd" | grep "sd[a-z][0-9]" | awk '{print "/dev/"$1}')
  echo "new usb found" > play.log
  # Unmount the drive if it's already mounted
  if [ -n "$new_drive" ]; then
    echo "Unmounting previously mounted USB drive $new_drive"
    umount -f $new_drive
    echo "USB was not properly unmounted. Some data may be corrupt. Please run fsck. " > play.log
  fi

  # Mount the new drive if one was found
  if [ -n "$new_drive" ]; then
    echo "Mounting new USB drive $new_drive"
    mount $new_drive /mnt/usb
   echo "new usb mount" > play.log
    # Search for audio files on the drive
    audio_files=$(find /mnt/usb -name "*.mp3" -o -name "*.wav")

    # Play audio files if any were found
    if [ -n "$audio_files" ]; then
      echo "Playing audio files $audio_files"
      for file in $audio_files; do
        mpg123 -C -f -100 $file
      done
    else
      echo "No audio files found on USB drive"
    fi

    # Unmount the drive
    echo "Unmounting USB drive /dev/$new_drive"
    umount -f /mnt/usb
    echo "USB was umounted" > play.log
  fi

  # Sleep for a few seconds before checking for new drives again
  sleep 5
done
