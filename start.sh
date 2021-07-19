#!/bin/sh

tunnel_to_db () {
    # Open a local tunnel to the environment.
    platform tunnel:close -y
    platform tunnel:open -y
    export PLATFORM_RELATIONSHIPS="$(platform tunnel:info --encode)"
}

# Local.
if [ -z ${PLATFORM_PROJECT_ENTROPY+x} ]; then 
    export MB_JETTY_PORT=${PORT}

    # Database Conection Info
    export MB_DB_TYPE=postgres
    export MB_DB_DBNAME=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode | jq -r ".database[0].path")
    export MB_DB_HOST=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode | jq -r ".database[0].host")
    export MB_DB_PORT=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode | jq -r ".database[0].port")
    export MB_DB_USER=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode | jq -r ".database[0].username")
    export MB_DB_PASS=$(echo $PLATFORM_RELATIONSHIPS | base64 --decode | jq -r ".database[0].password")

    # Limit heap size
    export MEM_AVAILABLE=500
    export JAVA_TOOL_OPTIONS="-Xmx${MEM_AVAILABLE}m -XX:+ExitOnOutOfMemoryError -Xlog:gc*"
    export JAR_FILE=$(pwd)/metabase/metabase.jar
else 
    export JAR_FILE=$PLATFORM_APP_DIR/metabase/metabase.jar
fi

echo $JAR_FILE

java -jar $JAR_FILE

# # Load header
# . ./header.inc

# # Port to Listen on
# export MB_JETTY_PORT=${PORT}

# # Database Conection Info
# export MB_DB_TYPE=postgres
# export MB_DB_DBNAME=$(bin/discovery PLATFORM_RELATIONSHIPS database.db.path)
# export MB_DB_PORT=$(bin/discovery PLATFORM_RELATIONSHIPS database.db.port)
# export MB_DB_USER=$(bin/discovery PLATFORM_RELATIONSHIPS database.db.username)
# export MB_DB_PASS=$(bin/discovery PLATFORM_RELATIONSHIPS database.db.password)
# export MB_DB_HOST=$(bin/discovery PLATFORM_RELATIONSHIPS database.db.host)

# # Email
# export MB_EMAIL_SMTP_HOST=$PLATFORM_SMTP_HOST
# export MB_EMAIL_SMTP_PORT=25
# export MB_EMAIL_SMTP_USERNAME=""
# export MB_EMAIL_SMTP_PASSWORD=""

# # Grab memory limits
# export MEM_AVAILABLE=$(bin/jq .info.limits.memory /run/config.json)

# # Limit heap size
# export JAVA_TOOL_OPTIONS="-Xmx${MEM_AVAILABLE}m -XX:+ExitOnOutOfMemoryError -XX:+PrintGCDetails"

# This ensures that the child process below gets stopped when Platform.sh kills this script.
# trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

#java -jar ${METABASE_HOME}/${METABASE_JAR} migrate release-locks
# exec java -jar ${METABASE_HOME}/${METABASE_JAR}
