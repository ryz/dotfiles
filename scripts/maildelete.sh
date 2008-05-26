#!/bin/bash
# maildelete.sh

ROOT_UID=0
MAIL_DIR=/var/spool/mail
MAILBOX=ryz
E_XCD=66
E_NOTROOT=67
E_MEMPTY=68
E_NOBOX=69

if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script. Aborting."
  exit $E_NOTROOT
fi

cd $MAIL_DIR

if [ "$PWD" != "$MAIL_DIR" ]
then
  echo "Can't change to $MAIL_DIR. Aborting."
  exit $E_XCD
fi

if [ -z "$MAILBOX" ]
then
  echo "Mailbox \"$MAILBOX\" already empty. Exiting."
  exit $E_MEMPTY
fi

if [ -e "$MAILBOX" ]
then
  echo "Wiping Mailbox \"$MAILBOX\"..."
  cat /dev/null > $MAILBOX
  echo "done."
else
  echo "Mailbox \"$MAILBOX\" doesn't exist. Aborting."
  exit $E_NOBOX
fi

exit 0
