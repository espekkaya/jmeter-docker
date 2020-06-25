#!/bin/bash
# Inspired from https://github.com/hhcordero/docker-jmeter-client
# Basically runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
#
# This script expects the standdard JMeter command parameters.
#
set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Keep entrypoint simple: we must pass the standard JMeter arguments
jmeter $@
echo "END Running Jmeter on `date`"

#     -n \
#    -t "/tests/${TEST_DIR}/${TEST_PLAN}.jmx" \
#    -l "/tests/${TEST_DIR}/${TEST_PLAN}.jtl"
# exec tail -f jmeter.log
#    -D "java.rmi.server.hostname=${IP}" \
#    -D "client.rmi.localport=${RMI_PORT}" \
#  -R $REMOTE_HOSTS



# export timestamp=$(date +%Y%m%d_%H%M%S) && \
# export volume_path=<where files are on host> && \
# export jmeter_path=/mnt/jmeter && \
# docker run \
#   --volume “${volume_path}”:${jmeter_path} \
#   jmeter \
#   -n <any sequence of jmeter args> \
#   -t ${jmeter_path}/<jmx_script> \
#   -l ${jmeter_path}/tmp/result_${timestamp}.jtl \
#   -j ${jmeter_path}/tmp/jmeter_${timestamp}.log 