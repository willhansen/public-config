# Based on bira theme

setopt prompt_subst

() {

# local MY_YELLOW="#969636"
local MY_YELLOW="#ffff00" # all yellow all the time
local PROFILE_ORANGE="#ff3f00"
local TRUE_RED="#ff0000"
local TRUE_YELLOW="#ffff00"


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




# 🟢🟡🔴 ⬤   
# ○ ◯  ⚫ ⵔ  ◌  ○  ◉  ⏼ ⏺  
#local GIT_STRING_FOR_BEHIND_REMOTE=""
#local GIT_STRING_FOR_UNADDED="🟢🟡🟡🔴 "
#local GIT_STRING_FOR_UNCOMMITTED="🟢🟡🟡 "
#local GIT_STRING_FOR_UNPUSHED="🟢🟡"
#local GIT_STRING_FOR_ALL_OKAY="🟢 "

apply_color() {
  local COLOR="$1"
  local TEXT="$2"
  echo -n "%F{$COLOR}$TEXT%f"
}

# ⭕𒊹 ⬤ 
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}𒊹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}𒊹%{$reset_color%}"
#↥↥↥↥ ↑↑↑⬆⬆⬆ ⭜⭜⭜⭜ 🠉🠉🠉 🠱🠱🠱 🠝🠝🠝 ⯭⯭⯭ 🢁🢁🢁 ⮝⮝⮝⮝🡅🡅🡅🡅🢕🢕🢕🢕⭎⭎⭎⭎🠵🠵🠵🠵🢙🢙🢙🢙⨇⨇⨇⨇ ⇈⇈⇈▲▲▲▲▴▴▴▴
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="$(apply_color $TRUE_YELLOW 🠉🠉🠉🠉) "
#⤓⤓⤓⤓↓↓↓⬇⬇⬇ ⭝⭝⭝⭝ 🠋🠋🠋 🠳🠳🠳 🠟🠟🠟 ⯯⯯⯯🢃🢃🢃⮟⮟⮟⮟🡇🡇🡇🡇🢗🢗🢗🢗⭏⭏⭏⭏🠷🠷🠷🠷🢛🢛🢛🢛▼▼▼▼
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="$(apply_color $TRUE_YELLOW 🠋🠋🠋🠋) "
#↕️↕️↕️ emoji  ⬍   ⥌⥍⥌⥍⥌⥍  ⇕ ⇳ ⥮⥯  ⇅⇵⇅⇵⇅⇵⇅⇵⇵⇵⇵⇵⇵ ↨↨↨↨ ⇊⇈⇊⇈⇊⇈⇊⇈
#⇈⇅⇊⇈⇅⇊⇈⇅⇊⇈⇅⇊ ↕↕↕ not emoji⬍⬍⬍ ⤨ ⤨⤨⤨ 🢗🢕🢗🢕🢗🢕
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="$(apply_color $TRUE_RED 🠉🠋🠉🠋🠉🠋🠉🠋) "

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

apply_bold() {
  echo -n "%B$1%b"
}
apply_italics() {
  echo -n "%B$1%b"
}

digit_seven_segment() {
  echo -n "$1" | sed -e 'y/0123456789/🯰🯱🯲🯳🯴🯵🯶🯷🯸🯹/'
}

shell_depth() {
  echo -n "$(apply_color $MY_YELLOW "$(digit_seven_segment "$(printf '%02d' $SHLVL)")")"
}

current_dir() {
  local TEXT=" %~"
  echo -n "$(apply_bold "$(apply_color blue "$TEXT")")"
}

return_code_string() {
  #local RETVAL
  #RETVAL="$?"
  #if [[ $RETVAL -ne 0 ]] then;
    #echo -n '%{%F{black}%K{red}%}${RETVAL}↵%k%f'
  #else
    #echo -n '%{%F{green}%}${RETVAL}↵%f'
  #fi 
  echo -n "%(?.%F{green}%?.%S%F{red} %? )↵ "
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
upper_left_decorator() {
  echo -n "$(apply_color $PROFILE_ORANGE "  ██")"
  # clear_formatting
}
# ◣ ◤
# ◺ ◸ 
lower_left_decorator() {
  echo -n "$(apply_color $PROFILE_ORANGE "██  ")"
  echo -n "🯁🯂🯃"
}

fancy_line_end() {
  echo -n "$(apply_color \#442222 "꧁ ꧂  ") $(apply_color \#2178ff "𐁙 ") $(apply_color \#ff20bb " 𐙀 ") $(apply_color \#555555 " ៚ 𑜿 ") $(apply_color \#f0f0f0 "𐃆 𐼽 ꫝꫜ ") $(apply_color \#409040 "𐀢꩜ ") $(apply_color blue "𒓎   ") ꘐ"
}

# $(apply_color \#402020 " 𑿛  𑿜  ") $(apply_color \#000000 " 𑿭 𑿿  ") 

fancy_roof() {
  echo -n "◯   🙼🙼 🙼🙼  ͞ ͞ ͞" 
}


local nix_prompt_string() {
  if [[ -n "$IN_NIX_SHELL" ]]; then
    echo -n "%F{white}$(font_blackboard 'N IX ')%f"
  fi
}

#᚜
# ◸╭⏾
# ◺╰ᚚ➤➤➤
PROMPT="$(upper_left_decorator)$(prompt_context) $(shell_depth)$(current_dir) \$(nix_prompt_string)${GIT_STRING}$(fancy_line_end)
$(lower_left_decorator)"
RPROMPT='⌚ $(date --rfc-3339=sec)  $(return_code_string)'

# vi mode additions
PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"
# Note the \$ here, which importantly prevents interpolation at the time of defining, but allows it to be executed for each prompt update event.

VI_MODE_SET_CURSOR=true

MODE_INDICATOR="%F{yellow}ᵛᶦ%f"


}


