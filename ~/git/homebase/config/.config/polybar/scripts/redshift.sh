
#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x redshift)" ]; then
            pkill redshift
        else
            redshift &
        fi
        ;;
    *)
        if [ "$(pgrep -x redshift)" ]; then
            echo "Redshift"
        else
            echo "Redshift"
        fi
        ;;
esac
