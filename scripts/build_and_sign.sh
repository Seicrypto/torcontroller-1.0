#!/bin/bash
set -e

export GPG_TTY=$(tty)
gpg --import private-key.asc
echo "allow-loopback-pinentry" >> ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 600" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 7200" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

echo "$GPG_PASSPHRASE" | gpg --batch --yes --passphrase-fd 0 --pinentry-mode loopback -o /tmp/signed_dummy_file --sign /etc/hostname

dpkg-buildpackage -k"$GPG_PUBLIC_KEY" -a"$ARCH"

# Write the name of the resulting .deb file to GITHUB_ENV
deb_file=$(ls ../torcontroller_*_"$ARCH".deb)
echo "deb_file=$deb_file" >> $GITHUB_ENV

dpkg-sig --sign builder --gpg-options="--pinentry-mode loopback" "$deb_file"