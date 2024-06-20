# Based on bira theme

setopt prompt_subst

() {

# local MY_YELLOW="#969636"
local MY_YELLOW="#ffff00" # all yellow all the time


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




local NIX_SHELL_FLAG_STRING

# Check if in nix shell
if [[ -n "$IN_NIX_SHELL" ]]; then
  # in nix shell
  NIX_SHELL_FLAG_STRING=' %F{white}【🅝 🅘 🅧  】%f'
  # 𝙽𝙸𝚇  🅽 🅸 🆇   
else
  # NOT in nix shell
  NIX_SHELL_FLAG_STRING=''
fi


# 🟢🟡🔴
# ○ ◯  ⚫ ⵔ  ◌  ○  ◉  ⏼ ⏺  
#local GIT_STRING_FOR_BEHIND_REMOTE=""
#local GIT_STRING_FOR_UNADDED="🟢🟡🟡🔴 "
#local GIT_STRING_FOR_UNCOMMITTED="🟢🟡🟡 "
#local GIT_STRING_FOR_UNPUSHED="🟢🟡"
#local GIT_STRING_FOR_ALL_OKAY="🟢 "

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} 🔴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%} 🟢%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[red]%}↓↓↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[red]%}↑↑↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[red]%}↕↕↕%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}❨ "
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{yellow}❩%f"

local GIT_STRING=' $(git_prompt_info) $(git_remote_status)'

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

apply_color() {
  local COLOR="$1"
  local TEXT="$2"
  echo -n "%F{$COLOR}$TEXT%f"
}
bold() {
  echo -n "%B$1%b"
}

digit_superscript() {
  echo -n "$1" | sed -e 'y/0123456789/⁰¹²³⁴⁵⁶⁷⁸⁹/'
}

fontify() {
 echo -n "$1" | sed -e "y/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz/$2/" 
}

font_mono() { fontify "$1" '𝙰𝙱𝙲𝙳𝙴𝙵𝙶𝙷𝙸𝙹𝙺𝙻𝙼𝙽𝙾𝙿𝚀𝚁𝚂𝚃𝚄𝚅𝚆𝚇𝚈𝚉𝚊𝚋𝚌𝚍𝚎𝚏𝚐𝚑𝚒𝚓𝚔𝚕𝚖𝚗𝚘𝚙𝚚𝚛𝚜𝚝𝚞𝚟𝚠𝚡𝚢𝚣' }
font_blackboard() { fontify "$1" '𝔸𝔹ℂ𝔻𝔼𝔽𝔾ℍ𝕀𝕁𝕂𝕃𝕄ℕ𝕆ℙℚℝ𝕊𝕋𝕌𝕍𝕎𝕏𝕐ℤ𝕒𝕓𝕔𝕕𝕖𝕗𝕘𝕙𝕚𝕛𝕜𝕝𝕞𝕟𝕠𝕡𝕢𝕣𝕤𝕥𝕦𝕧𝕨𝕩𝕪𝕫' }
font_fancy_cursive() { fontify "$1" '𝒜ℬ𝒞𝒟ℰℱ𝒢ℋℐ𝒥𝒦ℒℳ𝒩𝒪𝒫𝒬ℛ𝒮𝒯𝒰𝒱𝒲𝒳𝒴𝒵𝒶𝒷𝒸𝒹ℯ𝒻ℊ𝒽𝒾𝒿𝓀𝓁𝓂𝓃ℴ𝓅𝓆𝓇𝓈𝓉𝓊𝓋𝓌𝓍𝓎𝓏' }
font_cursive() { fontify "$1" '𝓐𝓑𝓒𝓓𝓔𝓕𝓖𝓗𝓘𝓙𝓚𝓛𝓜𝓝𝓞𝓟𝓠𝓡𝓢𝓣𝓤𝓥𝓦𝓧𝓨𝓩𝓪𝓫𝓬𝓭𝓮𝓯𝓰𝓱𝓲𝓳𝓴𝓵𝓶𝓷𝓸𝓹𝓺𝓻𝓼𝓽𝓾𝓿𝔀𝔁𝔂𝔃' }
font_gothic() { fontify "$1" '𝔄𝔅ℭ𝔇𝔈𝔉𝔊ℌℑ𝔍𝔎𝔏𝔐𝔑𝔒𝔓𝔔ℜ𝔖𝔗𝔘𝔙𝔚𝔛𝔜ℨ𝔞𝔟𝔠𝔡𝔢𝔣𝔤𝔥𝔦𝔧𝔨𝔩𝔪𝔫𝔬𝔭𝔮𝔯𝔰𝔱𝔲𝔳𝔴𝔵𝔶𝔷' }
font_bold_gothic() { fontify "$1" '𝕬𝕭𝕮𝕯𝕰𝕱𝕲𝕳𝕴𝕵𝕶𝕷𝕸𝕹𝕺𝕻𝕼𝕽𝕾𝕿𝖀𝖁𝖂𝖃𝖄𝖅𝖆𝖇𝖈𝖉𝖊𝖋𝖌𝖍𝖎𝖏𝖐𝖑𝖒𝖓𝖔𝖕𝖖𝖗𝖘𝖙𝖚𝖛𝖜𝖝𝖞𝖟' }
font_upside_down() { fontify "$1" 'ɐqɔpǝɟᵷɥᴉfʞꞁɯuodbɹsʇnʌʍxʎzɐqɔpǝɟᵷɥᴉfʞꞁɯuodbɹsʇnʌʍxʎz' }
font_tiny() { fontify "$1" 'ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ' }
font_serif_italic() { fontify "$1" '𝐴𝐵𝐶𝐷𝐸𝐹𝐺𝐻𝐼𝐽𝐾𝐿𝑀𝑁𝑂𝑃𝑄𝑅𝑆𝑇𝑈𝑉𝑊𝑋𝑌𝑍𝑎𝑏𝑐𝑑𝑒𝑓𝑔ℎ𝑖𝑗𝑘𝑙𝑚𝑛𝑜𝑝𝑞𝑟𝑠𝑡𝑢𝑣𝑤𝑥𝑦𝑧' }
font_serif_bold() { fontify "$1" '𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙𝐚𝐛𝐜𝐝𝐞𝐟𝐠𝐡𝐢𝐣𝐤𝐥𝐦𝐧𝐨𝐩𝐪𝐫𝐬𝐭𝐮𝐯𝐰𝐱𝐲𝐳' }
font_serif_bold_italic() { fontify "$1" '𝑨𝑩𝑪𝑫𝑬𝑭𝑮𝑯𝑰𝑱𝑲𝑳𝑴𝑵𝑶𝑷𝑸𝑹𝑺𝑻𝑼𝑽𝑾𝑿𝒀𝒁𝒂𝒃𝒄𝒅𝒆𝒇𝒈𝒉𝒊𝒋𝒌𝒍𝒎𝒏𝒐𝒑𝒒𝒓𝒔𝒕𝒖𝒗𝒘𝒙𝒚𝒛' }
font_sans() { fontify "$1" '𝖠𝖡𝖢𝖣𝖤𝖥𝖦𝖧𝖨𝖩𝖪𝖫𝖬𝖭𝖮𝖯𝖰𝖱𝖲𝖳𝖴𝖵𝖶𝖷𝖸𝖹𝖺𝖻𝖼𝖽𝖾𝖿𝗀𝗁𝗂𝗃𝗄𝗅𝗆𝗇𝗈𝗉𝗊𝗋𝗌𝗍𝗎𝗏𝗐𝗑𝗒𝗓' }
font_sans_i() { fontify "$1" '𝘈𝘉𝘊𝘋𝘌𝘍𝘎𝘏𝘐𝘑𝘒𝘓𝘔𝘕𝘖𝘗𝘘𝘙𝘚𝘛𝘜𝘝𝘞𝘟𝘠𝘡𝘢𝘣𝘤𝘥𝘦𝘧𝘨𝘩𝘪𝘫𝘬𝘭𝘮𝘯𝘰𝘱𝘲𝘳𝘴𝘵𝘶𝘷𝘸𝘹𝘺𝘻' }
font_sans_i_b() { fontify "$1" '𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙𝐚𝐛𝐜𝐝𝐞𝐟𝐠𝐡𝐢𝐣𝐤𝐥𝐦𝐧𝐨𝐩𝐪𝐫𝐬𝐭𝐮𝐯𝐰𝐱𝐲𝐳' }
font_sans_b_i() { fontify "$1" '𝑨𝑩𝑪𝑫𝑬𝑭𝑮𝑯𝑰𝑱𝑲𝑳𝑴𝑵𝑶𝑷𝑸𝑹𝑺𝑻𝑼𝑽𝑾𝑿𝒀𝒁𝒂𝒃𝒄𝒅𝒆𝒇𝒈𝒉𝒊𝒋𝒌𝒍𝒎𝒏𝒐𝒑𝒒𝒓𝒔𝒕𝒖𝒗𝒘𝒙𝒚𝒛' }
font_circle() { fontify "$1" 'ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏⓐⓑⓒⓓⓔⓕⓖⓗⓘⓙⓚⓛⓜⓝⓞⓟⓠⓡⓢⓣⓤⓥⓦⓧⓨⓩ' }
font_square() { fontify "$1" '🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉🄰🄱🄲🄳🄴🄵🄶🄷🄸🄹🄺🄻🄼🄽🄾🄿🅀🅁🅂🅃🅄🅅🅆🅇🅈🅉' }
font_runish() { fontify "$1" 'ꍏꌃꉓꀸꍟꎇꁅꃅꀤꀭꀘ꒒ꂵꈤꂦꉣꆰꋪꌗ꓄ꀎꃴꅏꊼꌩꁴꍏꌃꉓꀸꍟꎇꁅꃅꀤꀭꀘ꒒ꂵꈤꂦꉣꆰꋪꌗ꓄ꀎꃴꅏꊼꌩꁴ' }
font_runish_2() { fontify "$1" 'ꋫꃃꏸꁕꍟꄘꁍꑛꂑꀭꀗ꒒ꁒꁹꆂꉣꁸ꒓ꌚ꓅ꐇꏝꅐꇓꐟꁴꋫꃃꏸꁕꍟꄘꁍꑛꂑꀭꀗ꒒ꁒꁹꆂꉣꁸ꒓ꌚ꓅ꐇꏝꅐꇓꐟꁴ' }
font_runish_3() { fontify "$1" 'ꁲꋰꀯꂠꈼꄞꁅꍩꂑ꒻ꀗ꒒ꂵꋊꂦꉣꁷꌅꌚꋖꐇꀰꅏꇒꐞꁴꁲꋰꀯꂠꈼꄞꁅꍩꂑ꒻ꀗ꒒ꂵꋊꂦꉣꁷꌅꌚꋖꐇꀰꅏꇒꐞꁴ' }
font_runish_4() { fontify "$1" 'ꋫꃲꏸꄤꍟꄘꁍꑛꂑꀭꌅꇸꁒꍞꆂꇛꁸꋪꌚ꓅ꐇꏝꅐꊧꐟꁴꅔꋣꄡꁕꁄꌺꁅꀟꀧꆽꈵ꒒ꉈꍈꅂꉣꌜꎡꉖꇞ꒦ꃴꋃꉤꒄꋴ' }
font_runish_5() { fontify "$1" 'ꁲꃳꏳꀷꑀꊯꁅꁝ꒐꒑ꈵ꒒ꂵꃔꊿꉣꋠꌅꈜꋖꌈ꒦ꅐꉤꐔꑒꁲꃳꏳꀷꑀꊯꁅꁝ꒐꒑ꈵ꒒ꂵꃔꊿꉣꋠꌅꈜꋖꌈ꒦ꅐꉤꐔꑒ' }
font_emoji_blocks() { fontify "$1" '​🇦​​🇧​​🇨​​🇩​​🇪​​🇫​​🇬​​🇭​​🇮​​🇯​​🇰​​🇱​​🇲​​🇳​​🇴​​🇵​​🇶​​🇷​​🇸​​🇹​​🇺​​🇻​​🇼​​🇽​​🇾​​🇿​​🇦​​🇧​​🇨​​🇩​​🇪​​🇫​​🇬​​🇭​​🇮​​🇯​​🇰​​🇱​​🇲​​🇳​​🇴​​🇵​​🇶​​🇷​​🇸​​🇹​​🇺​​🇻​​🇼​​🇽​​🇾​​🇿' }
font_blocks() { fontify "$1" '🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉🅰🅱🅲🅳🅴🅵🅶🅷🅸🅹🅺🅻🅼🅽🅾🅿🆀🆁🆂🆃🆄🆅🆆🆇🆈🆉' }
font_lined() { fontify "$1" '₳฿₵ĐɆ₣₲ⱧłJ₭Ⱡ₥₦Ø₱QⱤ₴₮ɄV₩ӾɎⱫ₳฿₵ĐɆ₣₲ⱧłJ₭Ⱡ₥₦Ø₱QⱤ₴₮ɄV₩ӾɎⱫ' }
font_lined_2() { fontify "$1" 'ȺɃȻĐɆFǤĦƗɈꝀŁMNØⱣꝖɌSŦᵾVWXɎƵȺƀȼđɇfǥħɨɉꝁłmnøᵽꝗɍsŧᵾvwxɏƶ' }
font_whimsy() { fontify "$1" 'ᏗᏰፈᎴᏋᎦᎶᏂᎥᏠᏦᏝᎷᏁᎧᎮᎤᏒᏕᏖᏬᏉᏇጀᎩፚᏗᏰፈᎴᏋᎦᎶᏂᎥᏠᏦᏝᎷᏁᎧᎮᎤᏒᏕᏖᏬᏉᏇጀᎩፚ' }
font_whimsy_2() { fontify "$1" 'ᏗᏰፈᎴᏋᎦᎶᏂᎥᏠᏦᏝᎷᏁᎧᎮᎤᏒᏕᏖᏬᏉᏇጀᎩፚꮧᏸፈꮄꮛꭶꮆꮒꭵꮰꮶꮭꮇꮑꭷꭾꭴꮢꮥꮦꮼꮙꮗጀꭹፚ' }
font_bracketed() { fontify "$1" '⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵' }
font_bracketed_2() { fontify "$1" '🄐🄑🄒🄓🄔🄕🄖🄗🄘🄙🄚🄛🄜🄝🄞🄟🄠🄡🄢🄣🄤🄥🄦🄧🄨🄩⒜⒝⒞⒟⒠⒡⒢⒣⒤⒥⒦⒧⒨⒩⒪⒫⒬⒭⒮⒯⒰⒱⒲⒳⒴⒵' }
font_cyrilish() { fontify "$1" 'АБCДЄFGHЇJКГѪЙѲPФЯ$TЦѴШЖЧЗабcдёfgнїjкгѫпѳpфя$тцѵщжчз' }
font_cyrilish_2() { fontify "$1" 'ДБҀↁЄFБНІЈЌLМИФРQЯЅГЦVЩЖЧZаъсↁэfБЂіјкlмиорqѓѕтцvшхЎz' }
font_cyrilish_3() { fontify "$1" 'ѦБҪДЄӺԌӇЇJҜГѪЙѲPҀЯϨTЦѴШЖѰԐаъcдҿӻԍнїjкгѫпѳpҁяϛтцѵѿжѱԑ' }
font_accented() { fontify "$1" 'ÁBĆDÉFǴHíJḰĹḾŃŐṔQŔśTŰVẂXӲŹábćdéfǵhíjḱĺḿńőṕqŕśtúvẃxӳź' }
font_odd_lower() { fontify "$1" 'ABCDEFGHIJKLMNOPQRSTUVWXYZαႦƈԃҽϝɠԋιʝƙʅɱɳσρϙɾʂƚυʋɯxყȥ' }
font_umlaut() { fontify "$1" 'ÄḄĊḊЁḞĠḦЇJḲḶṀṄÖṖQṚṠṪÜṾẄẌŸŻäḅċḋëḟġḧïjḳḷṁṅöṗqṛṡẗüṿẅẍÿż' }
font_curvy() { fontify "$1" 'ᗩᗷᑕᗪEᖴGᕼIᒍKᒪᗰᑎOᑭᑫᖇᔕTᑌᐯᗯ᙭YᘔᗩᗷᑕᗪEᖴGᕼIᒍKᒪᗰᑎOᑭᑫᖇᔕTᑌᐯᗯ᙭Yᘔ' }
font_curvy_2() { fontify "$1" 'ᗩᗷᑢᕲᘿᖴᘜᕼᓰᒚKᒪᘻᘉᓍᕵᕴᖇSᖶᑘᐺᘺ᙭ᖻᗱᗩᗷᑢᕲᘿᖴᘜᕼᓰᒚkᒪᘻᘉᓍᕵᕴᖇSᖶᑘᐺᘺ᙭ᖻᗱ' }
font_curvy_3() { fontify "$1" 'ᗩᗷᑢᕲᘿᖴᘜᕼᓰᒚᔌᒪᘻᘉᓍᕵᕴᖇSᖶᑘᐺᘺ᙭ᖻᗱᗩᗷᑢᕲᘿᖴᘜᕼᓰᒚᔌᒪᘻᘉᓍᕵᕴᖇSᖶᑘᐺᘺ᙭ᖻᗱ' }
font_yatagan() { fontify "$1" 'ค๖¢໓ēfງhiวkl๓ຖ໐p๑rŞtนงຟxฯຊค๖¢໓ēfງhiวkl๓ຖ໐p๑rŞtนงຟxฯຊ' }
font_anchor() { fontify "$1" 'Ⱥβ↻ᎠƐƑƓǶįلҠꝈⱮហටφҨའϚͲԱỼచჯӋɀąҍçժҽƒցհìʝҟӀʍղօքզɾʂէմѵա×վՀ' }
font_l33t() { fontify "$1" '48(D3F9H!JK1MN0PQR57UVWXY248(d3f9h!jk1mn0pqr57uvwxy2' }
font_l33t_2() { fontify "$1" '48CD3F6H1JK1MN0PQr57UVWXYZ48CD3F6H1JK1MN0PQr57UVWXYZ' }
font_runesque() { fontify "$1" 'ꋬꉉ℃ꌛ℮℉ꍌꈚꊛꋒ㏍ꅤꀪꁣꇩꀆꆰꋪꈛ꓄ꀀ℣ꂸꊩꌦꍈꋬꉉ℃ꌛ℮℉ꍌꈚꊛꋒ㏍ꅤꀪꁣꇩꀆꆰꋪꈛ꓄ꀀ℣ꂸꊩꌦꍈ' }
font_ethiopish() { fontify "$1" 'ልጌርዕቿቻኗዘጎጋጕረጠክዐየዒዪነፕሁሀሠሸሃጊልጌርዕቿቻኗዘጎጋጕረጠክዐየዒዪነፕሁሀሠሸሃጊ' }
font_ethiopish_2() { fontify "$1" 'ል፪ርጋቹቻፏⶴጎፓኡረጮክዐየዓዪነፕ፱ህሠሸሃጊል፪ርጋቹቻፏⶴጎፓኡረጮክዐየዓዪነፕ፱ህሠሸሃጊ' }
font_webding() { fontify "$1" 'ꍏ♭☾◗€Ϝ❡♄♗♪ϰ↳♔♫⊙ρ☭☈ⓢ☂☋✓ω⌘☿☡ꍏ♭☾◗€Ϝ❡♄♗♪ϰ↳♔♫⊙ρ☭☈ⓢ☂☋✓ω⌘☿☡' }
font_money() { fontify "$1" 'AB¢₫€ƒgΩ¡j₭Lm₪Φ₽φ₹$₮ρν₩Χ¥Zab¢₫€ƒgΩ¡j₭Lm₪Φ₽φ₹$₮ρν₩Χ¥z' }
font_smallcaps() { fontify "$1" 'ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀsᴛᴜᴠᴡxʏᴢ' }
font_superscript() { fontify "$1" 'ᴬᴮᶜᴰᴱᶠᴳᴴᴵᴶᴷᴸᴹᴺᴼᴾᵠᴿˢᵀᵁⱽᵂˣʸᶻᵃᵇᶜᵈᵉᶠᵍʰᶦʲᵏˡᵐⁿᵒᵖᵠʳˢᵗᵘᵛʷˣʸᶻ' }
font_clippy() { fontify "$1" 'ᗣᙖᙅᙃᙓᖴᘜᕼꙆᒍКᒐᙏᙁOᕈᕋᖇᔑƮᙀᘎᙎXƳⱿᥲᑲᥴᑯᥱƒɠᖾɩʝƙꙆຕᥒoρϙɾ⳽tᥙʋωxყⱬ' }
font_clippy_2() { fontify "$1" 'ᗣ乃ᙅᗪᙓ千ᘜ卄ꙆﾌКㄥᙏ几O卩ᕋ尺ᔑㄒᙀᐯᙎ乂Ƴ乙ᗣ乃ᙅᗪᙓ千ᘜ卄ꙆﾌКㄥᙏ几O卩ᕋ尺ᔑㄒᙀᐯᙎ乂Ƴ乙' }
font_angley() { fontify "$1" '𐌀𐌁𐌂𐌃𐌄𐌅Ᏽ𐋅𐌉Ꮦ𐌊𐌋𐌌𐌍Ꝋ𐌓𐌒𐌐𐌔𐌕𐌵ᕓᏔ𐋄𐌙Ɀ𐌀𐌁𐌂𐌃𐌄𐌅Ᏽ𐋅𐌉Ꮦ𐌊𐌋𐌌𐌍Ꝋ𐌓𐌒𐌐𐌔𐌕𐌵ᕓᏔ𐋄𐌙Ɀ' }
font_stylin() { fontify "$1" 'ᕔᗹᙅᗫꗛꘘǤዛĬĴҜԸᙏᙁꗞᖘҨɌꕷꞆꚶᕓᙡ𐠷ᎽⱿᕔᗹᙅᗫꗛꘘǤዛĬĴҜԸᙏᙁꗞᖘҨɌꕷꞆꚶᕓᙡ𐠷ᎽⱿ' }
font_joker() { fontify "$1" 'ꛎꔪꛕ𖤀𖤢ꘘꚽꛅꛈꚠ𖢉ꚳ𖢑ꛘ𖣠ꛤꚩ𖦪ꕷ𖢧ꚶꚴꛃ𖤗ꚲꛉꛎꔪꛕ𖤀𖤢ꘘꚽꛅꛈꚠ𖢉ꚳ𖢑ꛘ𖣠ꛤꚩ𖦪ꕷ𖢧ꚶꚴꛃ𖤗ꚲꛉ' }
font_censored() { fontify "$1" 'A█C█E█G█IJKLM█OPQ█S█UVWXYZa█c█e█g█ijklm█opq█s█uvwxyz' }
font_redacted() { fontify "$1" '████████████████████████████████████████████████████' }
font_gresque() { fontify "$1" '𝛥𝛣𝐶𝐷𝛴𝐹𝐺𝛨𝛪𝐽𝛫𝐿𝛺𝛱𝛩𝛲𝛷𝛤𝑆𝛵𝑈𝛻𝑊𝛸𝛹𝛧𝛼𝛽𝜍𝛿𝜀𝑓𝑔𝜆𝑖𝑗𝜅𝜄𝑚𝜂𝜃𝜌𝜑𝛾𝑠𝜏𝜇𝜈𝜛𝜒𝜓𝑧' }
font_gresque_2() { fontify "$1" 'ΔΒⳞDΣҒGHΙJKLⲘΠΩϷQΓSϮⳘVϢЖΨⲌαβϲδєƒgнίנкιϻπθρqⲅϛτμγωжψⲍ' }
font_wide() { fontify "$1" 'ＡᗷＣᗪＥᖴＧᕼＩᒍＫ⎳ＭᑎＯᑭＱᖇＳ丅ＵᐯＷ᙭Ｙ乙ＡᗷＣᗪＥᖴＧᕼＩᒍＫ⎳ＭᑎＯᑭＱᖇＳ丅ＵᐯＷ᙭Ｙ乙' }
font_mathtastic() { fontify "$1" '⍲⌦⍧⟄ℇ🜅⅁ℍ⟟⏎⏧⎾⍓☊⌾⍴ℚ☈⎎⍑⌰⍻⏙🝍⍦☡⍲⌦⍧⟄ℇ🜅⅁ℍ⟟⏎⏧⎾⍓☊⌾⍴ℚ☈⎎⍑⌰⍻⏙🝍⍦☡' }
font_japanish() { fontify "$1" '丹日亡句ヨ乍呂廾工勹片し冊几回尸甲尺己卞凵レ山メと乙丹日亡句ヨ乍呂廾工勹片し冊几回尸甲尺己卞凵レ山メと乙' }
font_bleh() { fontify "$1" 'ⲀⲂⲤꓓⲈ⳨ⳊⲎⳔⳖⲔⳐⲘⲚⲞⳎⲪⲄⲊⲦⳘⳲⲰⲬⲨⲸⲁⲃⲥ𝖽ⲉ⳨ⳋⲏⳕⳗⲕⳑⲙⲛⲟⳏⲫⲅ⳽ⲧⳙⳳⲱⲭⲩⲹ' }




shell_depth() {
  local TEXT="⁽$(digit_superscript $SHLVL)⁾"

  echo -n $(apply_color $MY_YELLOW "$TEXT")
}

current_dir() {
  local TEXT=" %~"
  echo -n "$(bold "$(apply_color blue "$TEXT")")"
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

upper_left_decorator() {
  echo -n "%f$(apply_color '#ff8000' "🙾  ")"
  clear_formatting
}
# ◣ ◤
# ◺ ◸
lower_left_decorator() {
  echo -n "🯁🯂🯃 "
}

fancy_line_end() {
  echo -n "ꘐ ϡϠ   ㋡㋛"
}

#᚜
# ◸╭⏾
# ◺╰ᚚ➤➤➤
PROMPT="$(upper_left_decorator)$(prompt_context) $(shell_depth)$(current_dir)${NIX_SHELL_FLAG_STRING}${GIT_STRING} $(fancy_line_end)
$(lower_left_decorator)"
RPROMPT='⌚ $(date --rfc-3339=sec)  $(return_code_string)'

# vi mode additions
PROMPT="$PROMPT\$(vi_mode_prompt_info)"
RPROMPT="\$(vi_mode_prompt_info)$RPROMPT"
# Note the \$ here, which importantly prevents interpolation at the time of defining, but allows it to be executed for each prompt update event.

VI_MODE_SET_CURSOR=true

MODE_INDICATOR="%F{yellow}ᵛᶦ%f"


}


