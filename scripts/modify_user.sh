#!/bin/bash

echo "Updating user ( NAME=$NAME SURNAME=$SURNAME EMAIL=$EMAIL USERNAME=$USERNAME PASS=$PASS LIB_PATH=$LIB_PATH ) in LDAP" >> /tmp/ldap.log

cd $LIB_PATH

. setenv.sh
. ldap_functions.sh
. user_functions.sh

# check input

check

# LDAP rule
if [ -z "$PASS" ] || [ "$PASS" == "null" ]; then
	modify_ldap_user_conf_no_pass | modify_stdin $LOGFILE
else
	modify_ldap_user_conf | modify_stdin $LOGFILE
fi

if [ $? -gt 0 ]; then
	echo "Error updating user in LDAP: ref to $LOGFILE"
	exit 1;
else
	echo "'$USERNAME' user updated" >> $LOGFILE
	exit 0;
fi


