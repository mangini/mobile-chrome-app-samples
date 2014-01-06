#!/bin/bash

# stop if any command returns uncaught error
set -o pipefail
set -e

DIR=$1
if [ ! -d $DIR ] ; then
  echo "Usage: $0 <chrome_app_dir>"
  exit 1
fi

SUBDIR=`basename $DIR`
APP=`echo $SUBDIR | perl -pe 's/[^\w]//g'`
OUT="out/$SUBDIR"

mkdir -p $OUT
cp -R $DIR $OUT/chromeapp
cd $OUT
mca create org.chromium.$APP.MyApp --source=chromeapp
mv $APP mobile
cp mobile/www/config.xml chromeapp
cd mobile
rm -Rf www
ln -s ../chromeapp www
mca run
