cat /etc/hosts | while read ip nume rest
do
    case "$ip" in
        ""|\#*) continue ;;
    esac

    real=$(nslookup "$nume" 2>/dev/null | grep '^Address' | grep -v '#' | head -n 1 | awk '{print $2}')

    if [ "$real" != "$ip" ]; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
