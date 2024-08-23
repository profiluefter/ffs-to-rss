#!/bin/bash

read -p "Firefox username: " -r FFS_USERNAME
read -p "Firefox password: " -sr FFS_PASSWORD; echo

read -p "Use 2FA OTP? [Y/N] " -r FFS_USE_OTP

ADDITIONAL_ARGS=()
case "$FFS_USE_OTP" in
  [Yy]* )
  	read -p "OTP: " -r FFS_OTP
  	ADDITIONAL_ARGS+=("--otp=$FFS_OTP")
  ;;
  [Nn]* )
  ;;
  * )
    echo "Unknown input!"
    exit 1
  ;;
esac

ffsclient login \
  "$FFS_USERNAME" "$FFS_PASSWORD" \
  --device-name="FFS to RSS" --device-type="Script" \
  "${ADDITIONAL_ARGS[@]}"

echo "Your devices: "

ffsclient list clients --decoded
