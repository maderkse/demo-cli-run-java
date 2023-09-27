#!/bin/bash

set -e
source $SDKMAN_DIR/bin/sdkman-init.sh
sdk use java 20.0.2-tem
echo "Here shell means the subshell running the script."

# pre-run-testset-actions
basedir="$(dirname "$0")"
rm -rf jar bin

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
jar cf $basedir/jar/a.jar -C $basedir/bin A.class
jar tf $basedir/jar/a.jar
java -cp $basedir/jar/a.jar A
jar ufe $basedir/jar/a.jar A
jar xf $basedir/jar/a.jar META-INF/MANIFEST.MF
cat META-INF/MANIFEST.MF
rm -rf META-INF
java -jar $basedir/jar/a.jar
)
# pre-run-testset-actions
rm -rf jar bin
(
echo "-----------------------------------------------"
echo "demo: run simple pojo, with package"
echo "$basedir/src/B.java:"
cat $basedir/src/B.java

# tests
set -x
java $basedir/src/B.java
javac -d $basedir/bin $basedir/src/B.java
tree $basedir/bin --noreport
java -cp $basedir/bin b.B
jar cf $basedir/jar/b.jar -C $basedir/bin b/B.class
jar tf $basedir/jar/b.jar
java -cp $basedir/jar/b.jar b.B
jar ufe $basedir/jar/b.jar b.B
java -jar $basedir/jar/b.jar
)
echo "-----------------------------------------------"

# post-run-script-actions
rm -rf jar bin
