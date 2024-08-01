# Based on bira theme

setopt prompt_subst

() {

# local MY_YELLOW="#969636"
local MY_YELLOW="#ffff00" # all yellow all the time
local PROFILE_ORANGE="#ff3f00"
local NICE_CYAN="#00bfff"
local PROFILE_ICON_BG="$NICE_CYAN"
local TRUE_RED="#ff0000"
local TRUE_YELLOW="#ffff00"
local TEAL="#06989a"


local  U_R="#ef8aab"         #  hue  0
local  U_OR="#f48d7d"  #  hue  30
local  U_O="#e89954"      #  hue  60
local  U_Y="#cdaa41"      #  hue  90
local  U_YG="#a4ba57"      #  hue  120
local  U_G="#81c273"       #  hue  140
local  U_GB="#6ec482"          #  hue  150
local  U_GBB="#2cc8b1"         #  hue  180
local  U_GBBB="#13c3da"        #  hue  210
local  U_B="#58b8f6"           #  hue  240
local  U_P="#8fa9ff"           #  hue  270
local  U_V="#ba9bf3"           #  hue  300
local  U_M="#db8fd4"           #  hue  330

#local TURQUOISE ORANGE PURPLE RED GREEN
#if [[ $terminfo[colors] -ge 256 ]]; then
  #TURQUOISE="%F{81}"
  #ORANGE="%F{166}"
  #PURPLE="%F{135}"
  #RED="%F{161}"
  #GREEN="%F{118}"
#else
  #TURQUOISE="%F{cyan}"
  #ORANGE="%F{yellow}"
  #PURPLE="%F{magenta}"
  #RED="%F{red}"
  #GREEN="%F{green}"
#fi



# https://stackoverflow.com/questions/40827667/zsh-length-of-a-string-with-possibly-unicode-and-escape-characters
#
# Usage: prompt-length TEXT [COLUMNS]
#
# If you run `print -P TEXT`, how many characters will be printed
# on the last line?
#
# Or, equivalently, if you set PROMPT=TEXT with prompt_subst
# option unset, on which column will the cursor be?
#
# The second argument specifies terminal width. Defaults to the
# real terminal width.
#
# Assumes that `%{%}` and `%G` don't lie.
#
# Examples:
#
#   prompt-length ''            => 0
#   prompt-length 'abc'         => 3
#   prompt-length $'abc\nxy'    => 2
#   prompt-length '❎'          => 2
#   prompt-length $'\t'         => 8
#   prompt-length $'\u274E'     => 2
#   prompt-length '%F{red}abc'  => 3
#   prompt-length $'%{a\b%Gb%}' => 1
#   prompt-length '%D'          => 8
#   prompt-length '%1(l..ab)'   => 2
#   prompt-length '%(!.a.)'     => 1 if root, 0 if not
function prompt-length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=${#1} m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ))
    done
    while (( y > x + 1 )); do
      (( m = x + (y - x) / 2 ))
      (( ${${(%):-$1%$m(l.x.y)}[-1]} = m ))
    done
  fi
  echo $x
}

# form https://stackoverflow.com/questions/5799303/print-a-character-repeatedly-in-bash
#
# printf_n "a" 3
# aaa
function printf_n() {
 str=$1
 num=$2
 printf "%0.s$str" {1..$num}
}



# 🟢🟡🔴 ⬤   
# ○ ◯  ⚫ ⵔ  ◌  ○  ◉  ⏼ ⏺  
#local GIT_STRING_FOR_BEHIND_REMOTE=""
#local GIT_STRING_FOR_UNADDED="🟢🟡🟡🔴 "
#local GIT_STRING_FOR_UNCOMMITTED="🟢🟡🟡 "
#local GIT_STRING_FOR_UNPUSHED="🟢🟡"
#local GIT_STRING_FOR_ALL_OKAY="🟢 "

fg() {
  echo -n "%F{$1}$2%f"
}
bg() {
  echo -n "%K{$1}$2%k"
}
fgbg() {
  fg "$1" "$(bg "$2" "$3")"
}

# ⭕𒊹 ⬤ 
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}𒊹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}𒊹%{$reset_color%}"
#↥↥↥↥ ↑↑↑⬆⬆⬆ ⭜⭜⭜⭜ 🠉🠉🠉 🠱🠱🠱 🠝🠝🠝 ⯭⯭⯭ 🢁🢁🢁 ⮝⮝⮝⮝🡅🡅🡅🡅🢕🢕🢕🢕⭎⭎⭎⭎🠵🠵🠵🠵🢙🢙🢙🢙⨇⨇⨇⨇ ⇈⇈⇈▲▲▲▲▴▴▴▴
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$(fg $TRUE_YELLOW 🠉🠉🠉🠉) "
#⤓⤓⤓⤓↓↓↓⬇⬇⬇ ⭝⭝⭝⭝ 🠋🠋🠋 🠳🠳🠳 🠟🠟🠟 ⯯⯯⯯🢃🢃🢃⮟⮟⮟⮟🡇🡇🡇🡇🢗🢗🢗🢗⭏⭏⭏⭏🠷🠷🠷🠷🢛🢛🢛🢛▼▼▼▼
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$(fg $TRUE_YELLOW 🠋🠋🠋🠋) "
#↕️↕️↕️ emoji  ⬍   ⥌⥍⥌⥍⥌⥍  ⇕ ⇳ ⥮⥯  ⇅⇵⇅⇵⇅⇵⇅⇵⇵⇵⇵⇵⇵ ↨↨↨↨ ⇊⇈⇊⇈⇊⇈⇊⇈
#⇈⇅⇊⇈⇅⇊⇈⇅⇊⇈⇅⇊ ↕↕↕ not emoji⬍⬍⬍ ⤨ ⤨⤨⤨ 🢗🢕🢗🢕🢗🢕
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$(fg $TRUE_RED 🠉🠋🠉🠋🠉🠋🠉🠋) "

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}❨"
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{yellow}❩%f"

local GIT_STRING='$(git_prompt_info) $(git_remote_status)'

# ❨This🟡❩ ❨Is🟡❩ ❨A🟡❩ ❨Test🟡❩

# ❨This 🟡❩ ❨Is 🟡❩ ❨A 🟡❩ ❨Test 🟡❩

# ❨ This🟡❩ ❨ Is🟡❩ ❨ A🟡❩ ❨ Test🟡❩

# ❨ This 🟡❩ ❨ Is 🟡❩ ❨ A 🟡❩ ❨ Test 🟡❩

prompt_context() {

  local PR_USER PR_USER_OP PR_HOST
  # Check the UID
  if [[ $UID -ne 0 ]]; then # normal user
    PR_USER="%F{green}%n%f"
    PR_USER_OP="%F{green}%#%f"
  else # root
    PR_USER="%F{red}%n%f"
    PR_USER_OP="%F{red}%#%f"
  fi

  # Check if we are on SSH or not
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%F{red}%m%f' # SSH
  else
    PR_HOST="%F{green}%m%f" # no SSH
  fi

  echo -n "${PR_USER}%F{cyan}@${PR_HOST}"
}

clear_formatting() {
  # bold, underline, forground color, background color, and standout mode (whatever that is)
  echo -n "%{%b%u%f%k%s%}"
}

bold() {
  echo -n "%B$1%b"
}
# TODO: same as bold??
apply_italics() {
  echo -n "%B$1%b"
}

digit_seven_segment() {
  echo -n "$1" | sed -e 'y/0123456789/🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹/'
}

shell_depth() {
  echo -n "$(fg $MY_YELLOW "$(digit_seven_segment "$(printf '%02d' $SHLVL)")")"
}

current_dir() {
  local TEXT=" %~"
  echo -n "$(bold "$(fg blue "$TEXT")")"
}

return_code_string() {
  # local RETVAL
  # RETVAL="$?"
  # 
  echo -n "%(?.%F{green}%?.%S%F{red} %? )↵ "
  # if [[ $RETVAL -ne 0 ]] then;
  #   echo -n "🮴 "
  # else
  #   echo -n "🮱 "
  # fi 
  clear_formatting
}
# ╭≺
# ╰▶
#╭᚜
# 🙾
#   ██
# ██
# ◯ 🙼🙼 🙼🙼  
#
#▇▁█
# ⌜ ⌝ ⌞ ⌟ ◟◜◝◞
#
#   
upper_left_decorator() {
  echo -n "$(fg $PROFILE_ICON_BG "🮣")$(fg $PROFILE_ORANGE "  ▇▇")$(fg $PROFILE_ICON_BG "🮢")"
  # clear_formatting
}
# ◣ ◤
# ◺ ◸ 
# 🮆🮆
lower_left_decorator() {
  echo -n "$(fg $PROFILE_ICON_BG "🮡")$(fgbg "black" $PROFILE_ORANGE "▁▁")  $(fg $PROFILE_ICON_BG "🮠")$(fg $TEAL "🭨🭬❯")"
}

power_rangers() {
  #bpryb
  echo -n "$(fg $U_B "🯅")$(fg $U_M "🯈")$(fg $U_R "🯆")$(fg $U_Y "🯇")$(fg "#000000" "🯅")"
}

fancy_line_end() {
  echo -n "$(fg \#442222 "꧁ ꧂  ") $(fg \#2178ff "𐁙 ") $(fg \#ff20bb " 𐙀 ") $(fg \#555555 " ៚ 𑜿 ") $(fg \#f0f0f0 "𐃆 𐼽 ꫝꫜ ") $(fg \#409040 "𐀢꩜ ") $(fg blue "𒓎   ") ꘐ   🮲🮳"
}

# $(fg \#402020 " 𑿛  𑿜  ") $(fg \#000000 " 𑿭 𑿿  ") 

  # ◯   🙼🙼 🙼🙼  ͞ ͞ ͞ 


local nix_prompt_string() {
  if [[ -n "$IN_NIX_SHELL" ]]; then
    echo -n "%F{white}$(font_blackboard 'N IX ')%f"
  fi
}

#᚜
# ◸╭⏾
# ◺╰ᚚ➤➤➤

# No annoying indent on right
ZLE_RPROMPT_INDENT=0


local L_PROMPT="$(upper_left_decorator)$(prompt_context) $(shell_depth)$(current_dir) \$(nix_prompt_string)${GIT_STRING}$(fancy_line_end)"
local R_PROMPT="$(return_code_string)"

local L_LENGTH="99" #manually set
local R_LENGTH=$(prompt-length "$R_PROMPT")
local FILL_LENGTH="$(($COLUMNS-$L_LENGTH-$R_LENGTH))"

#$(printf_n "-" $FILL_LENGTH)
PROMPT="$L_PROMPT $R_PROMPT
$(lower_left_decorator)"
# RPROMPT='⌚ $(date --rfc-3339=sec)'

# vi mode additions
# PROMPT="$PROMPT\$(vi_mode_prompt_info)"
# RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"
# Note the \$ here, which importantly prevents interpolation at the time of defining, but allows it to be executed for each prompt update event.

# VI_MODE_SET_CURSOR=true

# MODE_INDICATOR="%F{yellow}ᵛᶦ%f"


}


