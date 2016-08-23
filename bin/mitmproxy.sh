# transparent proxy setup
# from http://docs.mitmproxy.org/en/stable/transparent/osx.html

enable_forwading () {
    sudo sysctl -w net.inet.ip.forwarding=1
}

add_rules () {
    # to view rules: sudo pfctl -s all
    # to clear rules: sudo pfctl -F nat
    cat <<EOF | sudo pfctl -f -
rdr on en0 inet proto tcp to any port 80 -> 127.0.0.1 port 8080
rdr on en0 inet proto tcp to any port 443 -> 127.0.0.1 port 8080
EOF
}

enable_pf () {
    # to disable: sudo pfctl -d
    sudo pfctl -e
}

enable_forwading
add_rules
enable_pf
