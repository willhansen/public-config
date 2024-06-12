
{ pkgs, ... }:
{

  home = {
    packages = with pkgs; [
      ripgrep # grep alternative
      fd # alternative to find
      bat # alternative to less
      htop
      nodePackages.bash-language-server
    ];
  };
  programs = {
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

        set -s set-clipboard on
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
      initExtra = "
        bind '\"\\e[A\":history-search-backward'
        bind '\"\\e[B\":history-search-forward'
      ";
      historySize = 10000; # 10k default
      historyFileSize = 100000; # 100k default
      shellOptions = [
         "checkwinsize"
         "histappend"

      ];



    };
  };
}
