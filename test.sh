#!/bin/bash

source $SDKMAN_DIR/bin/sdkman-init.sh
sdk use java 20.0.2-tem
echo "Here shell means the subshell running the script."

basedir="$(dirname "$0")"

(
echo "-----------------------------------------------"
echo "demo: run most simple pojo, no package"
echo "$basedir/src/A.java:"
cat $basedir/src/A.java

# tests
set -x
java src/A.java
javac -d $basedir/bin $basedir/src/A.java
java -cp $basedir/bin A
jar cf $basedir/jar/a.jar -c $basedir/bin A.class
jar tf $basedir/jar/a.jar
java -cp $basedir/jar/a.jar A
jar ufe $basedir/jar/a.jar A
jar xf $basedir/jar/a.jar meta-inf/manifest.mf
cat meta-inf/manifest.mf
rm -rf meta-inf
java -jar $basedir/jar/a.jar
)
#(
#echo "-----------------------------------------------"
#echo "demo: run simple pojo, with package"
#echo "$basedir/src/B.java:"
#cat $basedir/src/B.java
#
## tests
#set -x
#java $basedir/src/B.java
#javac -d $basedir/bin $basedir/src/B.java
#tree $basedir/bin --noreport
#java -cp $basedir/bin b.B
#)
echo "-----------------------------------------------"
