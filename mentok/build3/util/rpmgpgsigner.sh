#!/bin/sh
# Unattended RPM signing script suitable for use as a build3 EPM_PKGSIGN tool
#
# Unattended RPM signing is a pain in the ass.
#    --macros doesn't work as advertized, and rpm --sign absolutely always prompts the user.

RC=0
BIN_RPM=/bin/rpm
BIN_GPG=/usr/bin/gpg
if [ $# -lt 2 ]
then
    my_name=`basename $0`
    echo "Usage:"
    echo "    $my_name <gpg key file> <rpm file> [<rpm file> ...]"
    exit 99
fi
RPMSIGN_KEYFILE=$1
shift


#
# Import keyfile into a temporay keychain with just our one signing key
#
RPMSIGN_GPGHOME=/tmp/rpmsigner.gpghome.$$
GNUPGHOME=${RPMSIGN_GPGHOME}
export GNUPGHOME

rm -rf    $RPMSIGN_GPGHOME
mkdir -p  $RPMSIGN_GPGHOME
chmod 700 $RPMSIGN_GPGHOME

$BIN_GPG --verbose --import $RPMSIGN_KEYFILE
RC=`expr $RC + $?`

RPMSIGN_KEYNAME=`$BIN_GPG --list-keys | grep '^uid' | sed 's/(.*// ; s/^uid// ; s/^ *// ; s/ *$//' `
RC=`expr $RC + $?`


#
# Sign the RPM
#
/usr/bin/expect <<EOF
exp_internal 0

set gpg_name_arg "_gpg_name $RPMSIGN_KEYNAME"
spawn $BIN_RPM --verbose -D \$gpg_name_arg  --resign $*
expect "Enter pass phrase: " { send "\r" }
expect eof
catch wait rpm_status
exit [lindex \$rpm_status 3];

EOF
RC=`expr $RC + $?`

#
# Finish up
#
rm -rf    $RPMSIGN_GPGHOME
if [ $RC != 0 ]
then
    echo "ERROR: package signing failed" 1>&2
fi
exit $RC

