#!/usr/bin/env bash

cd /usr/local/spark
cp ./conf/spark-env.sh.template ./conf/spark-env.sh
echo 'export SPARK_DIST_CLASSPATH=$(/usr/local/hadoop/bin/hadoop classpath)' >> ./conf/spark-env.sh

# conf/slaves
# cp ./conf/slaves.template ./conf/slaves
