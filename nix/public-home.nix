
{ pkgs, ... }:
let 
  custom_zsh_dir = ".custom_zsh_stuff";
in {
  home = {

    sessionPath = [
      "$HOME/bin"
    ];

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

        ga = "git add";
        gaa = "git add --all";
        gs = "git status";
        gd = "git diff";
        gdc = "git diff --color-words";
        gdw = "gdc";
        gcm = "git commit -m";
        gcam = "git commit -am";
        amend = "git commit --amend";
        # gitgraph = " git log --oneline --graph --decorate --all";
        gitgraph = "git log --graph --pretty=\"%C(#9a9600)%h %C(#1f95f3)%ar %C(#e65d62)%s %C(auto)%d\" --date=human";
        # gitg = "gitgraph";
        gg = "gitgraph";

        # git diff, but without the +/- at line start
        gitcleandiff = "git diff --output-indicator-{old,new,context}=' '";

        copybranch = "git branch --show-current | xclip -rmlastnl -selection clipboard";
        cb = "copybranch";

        xc = "xcolor | tee /dev/tty | xclip -rmlastnl -selection clipboard";

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
      btop # htop alternative
      bottom # htop alternative
      glogg
      atop
      nodePackages.bash-language-server
      graphviz
      xcolor # color picker
      xclip
      bpftrace
      nerd-fonts.bigblue-terminal
      nerd-fonts.comic-shanns-mono 
      nerd-fonts.fira-code 
      nerd-fonts.monofur
      nerd-fonts.open-dyslexic
      nerd-fonts.proggy-clean-tt
      nerd-fonts.tinos
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
      sqlite
      sqlitebrowser
      sqldiff
      meld # merge tool
      jq #json parsing
      yq #yaml parsing
      stress #artificial pc load
      tealdeer #tldr
      multitail
      jsbeautifier # js autoformat
      linuxPackages.perf
      oxtools # 0x.tools
      repgrep # ripgrep + replace in-place
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
        # difftool."meld" = {
        #   cmd = "meld \"$LOCAL\" \"$REMOTE\"";
        # };
        merge.tool = "meld";
        # mergetool."meld" = {
        #   cmd = "meld \"$LOCAL\" \"$MERGED\" \"$REMOTE\" -o \"$MERGED\" --auto-merge";
        # };

      };
    };
    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      # theme here does not seem to work
      # colorTheme = "solarized-dark-256";
      # colorTheme = "bubblegum-256";
      colorTheme = "$HOME/.nix-profile/share/doc/task/rc/solarized-dark-256";
      dataLocation = "$HOME/.task";
      # config.hooks.location = "$HOME/.config/task/hooks";
      # extraConfig = "
        # include '$HOME/.nix-profile/share/doc/task/rc/solarized-dark-256.theme';
        # include solarized-dark-256.theme;
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
          # tmuxPlugins.cpu
            # {
            #   plugin = tmuxPlugins.resurrect;
            #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            # }
            # {
            #   plugin = tmuxPlugins.continuum;
            #   extraConfig = ''
            #     set -g @continuum-restore 'on'
            #     set -g @continuum-save-interval '60' # minutes
            #   '';
            # }
          # tmuxPlugins.tmux-thumbs
          # tmuxPlugins.sidebar

        ];

      extraConfig = builtins.readFile ./tmux.conf;
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

          # search replace
          rpl() {
            # rg "$1" --files-with-matches -0 | xargs -0 sed -i "s/$1/$2/g"
            fd --type file --exec sd "$1" "$2"
          }
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
