
{ pkgs, ... }:
{

  home = {
    shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";

        t = "task"; # for taskwarrior

        mysudo = "sudo env \"PATH=$PATH\"";
        nv = "nvim";
        nd = "nix develop";

        l = "ls";
        ll = "ls -l";
        la = "ls -a";
        lla = "ll -a";
        lal = "lla";

        gs = "git status";
        gd = "git diff";
        gcm = "git commit -m";
        gcam = "git commit -am";
        amend = "git commit --amend";
        # gitgraph = " git log --oneline --graph --decorate --all";
        gitgraph = "git log --graph --pretty=\"%C(#9a9600)%h %C(#1f95f3)%ar %C(#e65d62)%s \" --date=human";

        # gitg = "gitgraph";
        gg = "gitgraph";

        # update = "sudo nixos-rebuild switch";
        howbig = "du -hs * | sort -hr";
        big = "howbig";
        cpugraph = "btm --rate 250 --default_widget_type cpu --expanded";
        cpu = "cpugraph";
        showclipboard =
          "watch -n0.3 'echo \"\\n$(xsel -op)\\n$(xsel -os)\\n$(xsel -ob)\"'";
        open = "xdg-open";

    };
    packages = with pkgs; [
      ripgrep # grep alternative
      fd # alternative to find
      sd # alternative to sed
      bat # alternative to less
      htop
      nodePackages.bash-language-server
      graphviz
      xcolor # color picker
      comic-mono # TODO: get access to the font
      # font list: https://www.nerdfonts.com/font-downloads
      # ( nerdfonts.override { fonts = [ "FiraCode" ]; }) 
      nerdfonts
    ];
  };
  fonts.fontconfig.enable = true;
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "ComicShannsMono Nerd Font Mono";
          bold = {style = "Bold";};
          size = 9;

        };
      };

    };
    taskwarrior = {
      enable = true;
      # theme here does not seem to work
      colorTheme = "solarized-dark-256";
      dataLocation = "$HOME/.task";
      # extraConfig = "
      #   include solarized-dark-256.theme;
      # ";
    };
    tmux = {
      enable = true;

      # Stop tmux+escape craziness.
      escapeTime = 0;

      mouse = true;
      # keyMode = "vi";

      historyLimit = 100000;

      plugins = with pkgs;
        [

          # TODO: does not seem to work
          #tmuxPlugins.better-mouse-mode

          tmuxPlugins.yank
        ];

      extraConfig = ''
        # TODO: fix mouse scroll in non-mouse-enabled-but-scrolling applications like bacon and less
        #set -g @emulate-scroll-for-no-mouse-alternate-buffer "on"

        # TODO: why the extra `.` on the select pane commands?  indicates current window?
        bind -n M-h select-window -t :-
        bind -n M-l select-window -t :+
        bind -n M-k select-pane -t :.-
        bind -n M-j select-pane -t :.+

        # switch panes using Alt-arrow without prefix
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # terminator window splitting bindings
        bind -n M-O split-window -c "#{pane_current_path}" # split up-down
        bind -n M-E split-window -h -c "#{pane_current_path}" # split left-right
        bind -n M-X resize-pane -Z # zoom pane
        bind -n M-W kill-pane
        bind -n M-N new-window -c "#{pane_current_path}" # new tab
        bind -n M-< command-prompt -I'#W' { rename-window -- '%%' } # rename

        # rebind the default spit commands to have them open in current directory
        bind c new-window -c "#{pane_current_path}"
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # highlight title of zoomed tmux window
        setw -g window-status-current-format '#{?window_zoomed_flag,#[fg=red],}#F#I [#W] '

        # allow more colors
        set -g default-terminal "tmux-256color"
        # g for global, a for append, terminal-overrides to describe functionality of terminal outside tmux
        set -ga terminal-overrides ",xterm-256color:Tc"

        # Override the default copy to clipboard method (didn't seem to work on gnome terminal)
        set -s set-clipboard off 
        bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe "xclip -selection clipboard -i" \; send -X clear-selection
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      # coc.enable = true;
      extraLuaConfig = builtins.readFile ./nvim.lua;
      extraPackages = with pkgs;
        [
          gcc # for tree sitter
        ];
    };
    less = {
      enable = true;
      # --mouse enables mouse control (and lets tmux forward scrolling to less)
      # --wheel-lines=3 sets mouse wheel scroll speed
      # --incsearch enables incremental search
      # --search-options=W enables search wrap
      keys = ''
        #env
        LESS = -R --mouse --wheel-lines=3 --incsearch --search-options=W
      '';
    };
    fzf = { enable = true; };
    bash = {
      enable = true;
      # historyControl = [ "ignorespace" ]; 
      historyControl = [ "ignoreboth" ]; 
      enableCompletion = true;
      historySize =     100000000; # 100M (10k default)
      historyFileSize = 100000000; # 100M (100k default)
      # Change the file location because certain bash sessions truncate .bash_history file upon close.
      # http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
      # historyFile = "$HOME/.bash_eternal_history";
      shellOptions = [
         "checkwinsize"
         "histappend"

      ];
      shellAliases = {
        # "cd ..." = "cd ../..";
        # "cd ...." = "cd ../../..";
        # "cd ....." = "cd ../../../..";


      };
      bashrcExtra = "
        PROMPT_COMMAND=\"history -a; history -n\"

      ";
      initExtra = "
        # TODO: Can't use this because nix sets defaults first, and apparently history is truncated when the variable is set

        # Undocumented feature which sets the size to \"unlimited\".
        # http://stackoverflow.com/questions/9457233/unlimited-bash-history
        # export HISTFILESIZE=
        # export HISTSIZE=

        # HISTTIMEFORMAT=\"[%F %T] \"

        # search history with prefix with up and down arrows
        bind '\"\\e[A\":history-search-backward'
        bind '\"\\e[B\":history-search-forward'

        # better autocomplete options on tab
        bind 'set show-all-if-ambiguous on'
        bind 'TAB:menu-complete'
      ";
    };
  };
}
