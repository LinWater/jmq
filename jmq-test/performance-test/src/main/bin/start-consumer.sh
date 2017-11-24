#!/bin/sh

BASEDIR=`dirname $0`/..
BASEDIR=`(cd "$BASEDIR"; pwd)`

# If a specific java binary isn't specified search for the standard 'java' binary
if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD=`which java`
  fi
fi

CLASSPATH="$BASEDIR"/conf/:"$BASEDIR"/lib/*
CONFIG_FILE="$BASEDIR/conf/test.properties"
echo "$CLASSPATH"

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly."
  echo "  We cannot execute $JAVACMD"
  exit 1
fi


OPTS_MEMORY=`grep -ios 'opts.memory=.*$' ${CONFIG_FILE} | tr -d '\r'`
OPTS_MEMORY=${OPTS_MEMORY#*=}

#DEBUG_OPTS="-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5006"
#JPROFILER="-agentpath:/export/App/jprofiler9/bin/linux-x64/libjprofilerti.so=port=8849,nowait "
nohup "$JAVACMD" $JAVA_OPTS \
  $OPTS_MEMORY $DEBUG_OPTS \
  $JPROFILER \
  -classpath "$CLASSPATH" \
  -Dbasedir="$BASEDIR" \
  -Dfile.encoding="UTF-8" \
  com.ipd.jmq.test.performance.kafka.KafkaConsumerTest \
  "$@" >/dev/null 2>/dev/null &