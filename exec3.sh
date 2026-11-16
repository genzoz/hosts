verifica_ip() {
    host_name="$1"
    addr="$2"
    server="$3"

    real=$(nslookup "$host_name" "$server" 2>/dev/null | grep '^Address' | grep -v '#' | head -n 1 | awk '{print $2}')

    [ "$real" = "$addr" ]
}

DNS_SERVER="8.8.8.8"

cat /etc/hosts | while read ip nume rest
do
    case "$ip" in
        ""|\#*) continue ;;
    esac

    if ! verifica_ip "$nume" "$ip" "$DNS_SERVER"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
