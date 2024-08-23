#!/bin/bash

read -p "Firefox username: " -r FFS_USERNAME
read -p "Firefox password: " -sr FFS_PASSWORD; echo

read -p "Use 2FA OTP? [Y/N] " -r FFS_USE_OTP

case "$FFS_USE_OTP" in
  [Yy]* )
  	read -p "OTP: " -r FFS_OTP
  	FFS_OTP="--otp=$FFS_OTP"
  ;;
  [Nn]* )
  	FFS_OTP=""
  ;;
  * )
    echo "Unknown input!"
    exit 1
  ;;
esac

ffsclient login \
  "$FFS_USERNAME" "$FFS_PASSWORD" \
  --device-name="FFS to RSS" --device-type="Script" \
  "$FFS_OTP"
