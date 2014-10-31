#!/usr/bin/env bash

JDK_HOME=`pwd`

JVM_COMMON_BUILDPACK=http://lang-jvm.s3.amazonaws.com/jvm-buildpack-common-v3.tar.gz
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
