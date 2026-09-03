list-apks() {
    if [ -n "$1" ]; then
        adb shell "pm list packages -3 | sed 's/package://' | grep -i '$1'"
    else
        adb shell "pm list packages -3 | sed 's/package://'"
    fi
}

pull-apks() {
    if [ -z "$1" ]; then
        echo -e "\e[31m[-] Error: Package name cannot be null. Ex: pull-apks com.example\e[0m"
        return 1
    fi

    local pkg_name="$1"
    
    local paths=$(adb shell pm path "$pkg_name" | tr -d '\r')

    if [ -z "$paths" ]; then
        echo -e "\e[31m[-] Package '$pkg_name' not found on the device.\e[0m"
        return 1
    fi

    mkdir -p "./$pkg_name"
    echo -e "\e[36m[+] Extracting APKs from '$pkg_name'\e[0m"

    for line in $paths; do
        local apk_path="${line#package:}"
        
        if [ -n "$apk_path" ]; then
            echo "-> Pulling: $apk_path"
            adb pull "$apk_path" "./$pkg_name/"
        fi
    done
    
    echo -e "\e[32m[+] Complete!\e[0m"
}

frida-on() {
    local bin_name="${1:-frida-server}"
    local path="/data/local/tmp/$bin_name"
    echo -e "\e[36m[+] Starting $bin_name in background\e[0m"
    adb shell "su -c 'chmod +x $path && nohup $path >/dev/null 2>&1 &'"
}

frida-off() {
    local bin_name="${1:-frida-server}"
    echo -e "[-] Killing $bin_name..."
    adb shell "su -c 'killall -9 $bin_name 2>/dev/null'"
    echo -e "\e[32m[+] Server stopped!\e[0m"
}

get-front() {
    echo -e "\e[36m[+] Frontmost App (Current Focus):\e[0m"
    adb shell "dumpsys window | grep mCurrentFocus"
}

burp-on() {
    adb reverse tcp:8080 tcp:8080
    adb shell settings put global http_proxy 127.0.0.1:8080

    echo -e "\e[36m[+] Proxy ON - 127.0.0.1:8080\e[0m"
}

burp-off() {
    adb shell settings put global http_proxy :0
    adb reverse --remove tcp:8080

    echo -e "\e[32m[-] Proxy OFF\e[0m"
}