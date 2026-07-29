#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# All DNF-related operations should be done here whenever possible

# shellcheck source=build_files/shared/copr-helpers.sh
source /ctx/build_files/shared/copr-helpers.sh

# NOTE:
# Packages are split into FEDORA_PACKAGES and COPR_PACKAGES to prevent
# malicious COPRs from injecting fake versions of Fedora packages.
# Fedora packages are installed first in bulk (safe).
# COPR packages are installed individually with isolated enablement.

# Base packages from Fedora repos - common to all versions
FEDORA_PACKAGES=(
    aria2
    asciidoc
    dnscrypt-proxy
    fd-find
    glow
    mathjax-typewriter-fonts
    moreutils
    neovim
    overpass-fonts
    overpass-mono-fonts
    pandoc
    parallel
    polarsys-b612-fonts
    poppler
    poppler-utils
    proxychains-ng
    ripgrep
    sshuttle
    tor
    urw-base35-fonts
    xorriso
    hackrf
    hackrf-devel
    libuhd-devel
    rtl-sdr
    rtl-sdr-devel
    SoapySDR
    SoapySDR-devel
    soapysdr-module-hackrf
    soapy-rtlsdr
    soapysdr-tools
    uhd-host
)


# Install all Fedora packages (bulk - safe from COPR injection)
echo "Installing ${#FEDORA_PACKAGES[@]} packages from Fedora repos..."
dnf -y install "${FEDORA_PACKAGES[@]}"

# From robot/veracrypt
copr_install_isolated "bigjapka/VeraCrypt" "veracrypt"

# From lukasfr/ripgrep-all
copr_install_isolated "lukasfr/ripgrep-all" "ripgrep-all"

# From starship/starship
copr_install_isolated "atim/starship" "starship"

# From supervillain/i2pd
copr_install_isolated "supervillain/i2pd" "i2pd"


echo "::endgroup::"
