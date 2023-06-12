r-delregion() {
    if ((REGION_ACTIVE)) then
        zle kill-region
    else 
        local widget_name=$1
        shift
        zle $widget_name -- $@
    fi
}

r-unselect() {
    REGION_ACTIVE=0
    local widget_name=$1
    shift
    zle $widget_name -- $@
}

r-select() {
    ((REGION_ACTIVE)) || zle set-mark-command
    local widget_name=$1
    shift
    zle $widget_name -- $@
}

for key             kcap    seq         mode        widget (
    left            kcub1   $'\EOD'     unselect    backward-char
    right           kcuf1   $'\EOC'     unselect    forward-char
    shift-left      kLFT    $'\E[1;2D'  select      backward-char
    shift-right     kRIT    $'\E[1;2C'  select      forward-char
    opt-left        x       $'\E[1;3D'  unselect    backward-word
    opt-right       x       $'\E[1;3C'  unselect    forward-word
    cmd-left        x       $'\E[1;9D'  unselect    beginning-of-line
    cmd-right       x       $'\E[1;9C'  unselect    end-of-line
    shift-opt-left  x       $'\E[1;4D'  select      backward-word
    shift-opt-right x       $'\E[1;4C'  select      forward-word
    shift-cmd-left  x       $'\E[1;10D' select      beginning-of-line
    shift-cmd-right x       $'\E[1;10C' select      end-of-line
    del             kdch1   $'\E[3~'    delregion   delete-char
    bs              x       $'^?'       delregion   backward-delete-char
    ) {

    eval "key-$key() {
        r-$mode $widget \$@
    }"
    zle -N key-$key
    bindkey ${terminfo[$kcap]-$seq} key-$key
}

