
function mkcd() {
   mkdir -p "$@" && cd "$_";
}

function bak() {
	cp -r "$1" "$1-$(date +%s)"
}

function bakm() {
	mv "$1" "$1-$(date +%s)"
}

function lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

function which_term () {
     term=$(ps -p $(ps -p $$ -o ppid=) -o args=);
     found=0;
     case $term in
         *gnome-terminal*)
             found=1
             echo "gnome-terminal " $(dpkg -l gnome-terminal | awk '/^ii/{print $3}')
             ;;
         *lxterminal*)
             found=1
             echo "lxterminal " $(dpkg -l lxterminal | awk '/^ii/{print $3}')
             ;;
         rxvt*)
             found=1
             echo "rxvt " $(dpkg -l rxvt | awk '/^ii/{print $3}')
             ;;
         ## Try and guess for any others
         *)
             for v in '-version' '--version' '-V' '-v'
             do
                 $term "$v" &>/dev/null && eval $term $v && found=1 && break
             done
             ;;
     esac
     ## If none of the version arguments worked, try and get the 
     ## package version
     [ $found -eq 0 ] && echo "$term " $(dpkg -l $term | awk '/^ii/{print $3}')    
 }
