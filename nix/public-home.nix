
{ pkgs, ... }:
let 
  custom_zsh_dir = ".custom_zsh_stuff";
in {
  home = {

    # This is how to copy a directory from the config folder to the home folder
    file."${custom_zsh_dir}/themes/custom.zsh-theme".source =
      ./custom.zsh-theme;

    shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        # "cd ..." = "cd ../..";
        "...." = "cd ../../..";
        # "cd ...." = "cd ../../..";
        "....." = "cd ../../../..";
        # "cd ....." = "cd ../../../..";
        "......" = "cd ../../../../..";
        # "cd ......" = "cd ../../../../..";

        t = "task"; # for taskwarrior
        tl = "task long limit:10";
        tla = "task long";
        savetasks = "pushd ~/.task && ./do_export.sh && git commit -am 'update' && git push && popd";

        mysudo = "sudo env \"PATH=$PATH\"";
        nv = "nvim";
        nd = "nix develop";

        ls = "ls --color=auto";
        l = "ls";
        ll = "ls -lh";
        la = "ls -a";
        lla = "ll -a";
        lal = "lla";

        gs = "git status";
        gd = "git diff";
        gcm = "git commit -m";
        gcam = "git commit -am";
        amend = "git commit --amend";
        # gitgraph = " git log --oneline --graph --decorate --all";
        gitgraph = "git log --graph --pretty=\"%C(#9a9600)%h %C(#1f95f3)%ar %C(#e65d62)%s %C(auto)%d\" --date=human";
        # gitg = "gitgraph";
        gg = "gitgraph";

        # git diff, but without the +/- at line start
        gitcleandiff = "git diff --output-indicator-{old,new,context}=' '";

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
      atop
      nodePackages.bash-language-server
      graphviz
      xcolor # color picker
      comic-mono # TODO: get access to the font
      bpftrace
      # font list: https://www.nerdfonts.com/font-downloads
      #TODO: maybe only get specific fonts, because they are big
      ( nerdfonts.override { fonts = [ "ComicShannsMono" "FiraCode" ]; }) 
      # nerdfonts
      sqlite
      sqlitebrowser
      meld # merge tool
      jq #json parsing
      stress #artificial pc load
      tealdeer #tldr
    ];
  };
  fonts.fontconfig.enable = true;
  services = {

    flameshot = {
      # TODO: enable after nix desktop shortcuts are sorted out
      enable = false;
      settings = {
        General = {
          showStartupLaunchMessage = false;
          # flameshot does not support any sort of relative path or variable expansion
          savePath="/home/will/Pictures/screenshots";
          savePathFixed=true;
          saveAfterCopy= true ;
          predefinedColorPaletteLarge = true;
          drawThickness=5;
          filenamePattern="screenshot_%F_%H-%M";
        };
        Shortcuts = {
          TYPE_MOVESELECTION="Q";
        };
      };
    };
  };
  programs = {
    git = {
      enable = true;
      aliases = {
        lga = "lg --all";
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(auto)%d%C(reset)'";
      };
      extraConfig = {
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        diff.tool = "meld";
        difftool."meld" = {
          cmd = "meld \"$LOCAL\" \"$REMOTE\"";
        };
        merge.tool = "meld";
        mergetool."meld" = {
          cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" -o \"$MERGED\" --auto-merge";
        };

      };
    };
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      # theme here does not seem to work
      colorTheme = "solarized-dark-256";
      dataLocation = "$HOME/.task";
      # config.hooks.location = "$HOME/.config/task/hooks";
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
        bind -n M-R respawn-pane -k # respawn pane, killing running processes
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
        
        set -g @plugin 'tmux-plugins/tmux-yank'

        # Override the default copy to clipboard method (didn't seem to work on gnome terminal)
        # set -s set-clipboard off 
        # bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe "xclip -selection clipboard -i" \; send -X clear-selection
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

    zsh = {
      enable = true;
      # TODO: fix
      #syntaxHighlighting.enable = true;
      history = {
        extended = true;
        save = 100000000; # 10M (10k default)
        size = 100000000; # 10M (10k default)
      };
      historySubstringSearch.enable = true;
      shellAliases = {
        # l =
        #   "exa --icons --grid --classify --color=auto --sort=type --group-directories-first --header --modified --created --git --binary --group";
        # update = "sudo nixos-rebuild switch";
      };
      # TODO: need this?
      #history = {
      #size = 10000;
      #path = "${config.xdg.dataHome}/zsh/history";
      #};
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ]; # "vi-mode" ];
        # This is how to reference the directory the configuration file is in (or its readonly copy, at least)
        # Note that the the folder must be checked in to git to be recognized by nix
        #custom = builtins.toString ./. + "/${custom_zsh_dir}"; 
        custom = "$HOME/${custom_zsh_dir}";
        theme = "custom";
        extraConfig = ''
          # Skip only the aliases from the git plugin
          zstyle ':omz:plugins:git' aliases no
        '';
      };
      initExtra = ''
        	# That reads "if $SSH_AUTH_SOCK is a socket (-S) and not a symbolic link (! -h), create a new symbolic link at the known path. In all cases, redefine SSH_AUTH_SOCK to point to the known path.

        	# The ! -h avoids creating a circular reference if you run this multiple times.

        	# Works great, but breaks when using remotely mounted home folders. In that case, use ~/.ssh/ssh_auth_sock_"$(hostname)" for your symlink. It will keep separate auth sockets for each host.

        	local known_ssh_auth_sock_path=~/.ssh/ssh_auth_sock_"$(hostname)"
        	if [ -S "$SSH_AUTH_SOCK" ] && [ ! -h "$SSH_AUTH_SOCK" ]; then
            ln -sf "$SSH_AUTH_SOCK" "$known_ssh_auth_sock_path"
        	fi
        	export SSH_AUTH_SOCK="$known_ssh_auth_sock_path"
        	'';
    };
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
