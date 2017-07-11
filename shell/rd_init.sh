# root directory
export RD_ROOT_DIR=/opt2/jupengfei/.rmd
export HOST_OS=linux

# lua environment
export LUA_INIT=@$RD_ROOT_DIR/src/lua_init.lua

# set lua parse position
export LUA_EXE=$RD_ROOT_DIR/bin/linux/lua

# put rd command in standard path
export PATH=$PATH:$RD_ROOT_DIR/shell

# alias 
source $RD_ROOT_DIR/shell/alias.sh

export RD_SERVER_IP=
export RD_SERVER_PORT=30130

export RD_CLIENT_IP=172.25.105.14
export RD_CLIENT_PORT=30130

# server address
get_host_ip_port () {
    local ip=`ifconfig eth0|awk -F : '/inet /{print $2}'`
    RD_SERVER_IP=${ip%% *}
}

# start rd_server
start_rd_server() {
    local lua_cmd="$LUA_EXE $RD_ROOT_DIR/src/rd_server.lua"

    if ! ps -ef|grep -v grep|grep "$lua_cmd" &>/dev/null; then
        ($lua_cmd &)
    fi
}

start_server=$1
if [ "$start_server" == "true" ]; then
    get_host_ip_port
    start_rd_server
fi
