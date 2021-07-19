#!/bin/bash

# Local.
if [ -z ${PLATFORM_PROJECT_ENTROPY+x} ]; then 
    echo "Building Metabase locally"
    METABASE_VERSION=$(platform app:config-get -P variables.env.METABASE_VERSION)
    METABASE_HOME=$(pwd)/metabase
# Platform.sh.
else
    echo "Building Metabase on Platform.sh"
    METABASE_HOME=${PLATFORM_APP_DIR}/metabase
fi

# Download Metabase.
echo "Downloading Metabase ($METABASE_VERSION)"
wget --no-cookies --no-check-certificate -q -O \
    "$METABASE_HOME/metabase.jar" "http://downloads.metabase.com/v$METABASE_VERSION/metabase.jar"
