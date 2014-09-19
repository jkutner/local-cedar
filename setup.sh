#!/usr/bin/env bash

JDK_HOME=`pwd`

JVM_COMMON_BUILDPACK=http://lang-jvm.s3.amazonaws.com/jvm-buildpack-common-v2.tar.gz
mkdir -p /tmp/jvm-common
curl --silent --location $JVM_COMMON_BUILDPACK | tar xzm -C /tmp/jvm-common
. /tmp/jvm-common/bin/util
. /tmp/jvm-common/bin/java

# install JDK
javaVersion=$(detect_java_version ${JDK_HOME})
echo -n " ---> Installing OpenJDK ${javaVersion}..."
install_java ${JDK_HOME} ${javaVersion}
jdk_overlay ${JDK_HOME}
echo " done"


SBT_VERSION="0.13.5"
SBT_JAR="sbt-launch.jar"
SBT_URL="http://typesafe.artifactoryonline.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.5/$SBT_JAR"
SBT_BINDIR=.sbt_home
mkdir -p "$SBT_BINDIR"
cd "$SBT_BINDIR"

## clean up any old versions
/bin/rm -f sbt sbt-launch-*.jar || true

echo -n " ---> Downloading SBT..."
curl --silent --max-time 60 -O --location $SBT_URL --fail || error "Failed to download $SBT_JAR"
echo "done"
