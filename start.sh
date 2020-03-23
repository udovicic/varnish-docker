#!/bin/sh

if [ -z "${MEMORY_SIZE}" ]; then
  MEMORY_SIZE="1024M"
fi

if [ -z "${VCL_PATH}" ] && [ -f "/etc/varnish/conf.d/default.vcl" ]; then
  VCL_PATH="/etc/varnish/conf.d/default.vcl"
fi

if [ -n "${VCL_PATH}" ]; then
    echo "Booting using config file ${VCL_PATH}"
    varnishd -s malloc,${MEMORY_SIZE} -a :80 -f ${VCL_PATH}
else
    echo "Booting using 127.0.0.1:8080 as backend"
    varnishd -s malloc,${MEMORY_SIZE} -a :80 -b 127.0.0.1:8080
fi

varnishlog