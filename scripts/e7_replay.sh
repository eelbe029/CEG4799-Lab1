#!/bin/bash
# T7: replay the E6a injection payload against the fixed program
rm -f /tmp/E6A_PROOF
cd "$(dirname "$0")/../Labsetup" || exit 1
./catall_fixed '/dev/null; /usr/bin/id -u; /usr/bin/id -ru; /usr/bin/touch /tmp/E6A_PROOF'
ls -l /tmp/E6A_PROOF
