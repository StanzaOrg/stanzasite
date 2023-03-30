#!/bin/bash
set -Eeuxo pipefail
PS4='>>> '
TOP="${PWD}"

# Add a new version of Stanza to the downloads page

# This script is designed to be run from a Concourse Task with the following env vars

USAGE="STANZA_VER=0.17.56 $0"

# Required env var inputs
echo "     STANZA_VER:" "${STANZA_VER:?Usage: ${USAGE}}"  # new version of stanza to add to the downloads page

# Defaulted env var inputs - can override if necessary
echo "        REPODIR:" "${REPODIR:=stanzasite}"                     # root directory for the repository to update
echo "STANZA_REL_DATE:" "${STANZA_REL_DATE:=$(date +"%B %d, %Y")}"   # new release date string like "December 31, 2023"

DLFILE="${REPODIR}/src/downloads.gen"

# Extract previous version and date from line like "\exstanza(0.18.7){March 13, 2023}"
PREVEXLINE=$(grep '^\\exstanza(.*){.*}' "${DLFILE}" | head -1)
PREVEXVER=$(sed -n 's/.*(\([^()]*\)).*/\1/p'  <<<${PREVEXLINE})
PREVEXDATE=$(sed -n 's/.*{\([^()]*\)}.*/\1/p'  <<<${PREVEXLINE})

# Update exstanza line to new version
# Add previous version under "\subheader{Older Versions}"
sed -i'.bak' \
    -e "s/^\\\exstanza.*/\\\exstanza(${STANZA_VER}){${STANZA_REL_DATE}}/" \
    -e "s/^\(\\\subheader{Older.*\)/\1\n\\\oldexstanza_w(${PREVEXVER}){${PREVEXDATE}}/" \
    "$DLFILE"
