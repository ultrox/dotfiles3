{ config, pkgs, ... }:

let
  dotfiles = "/home/marko/dotfiles";
in

{
  xsession = {
    enable = true;
    initExtra = ''
      did=$(xinput list|grep 'Logitech G903 LS.*pointer'|grep -o 'id=[0-9][0-9]'|cut -d= -f2);
      /usr/bin/xinput set-button-map $did 3 2 1;
    '';
  };
  home = {
    # file = {
    #     ".config/espanso" = {
    #       source = "/home/marko/dotfiles/espanso";
    #       recursive = true;
    #     };
    # }; 
    username = "marko";
    homeDirectory = "/home/marko";
    sessionPath = [ "$HOME/dotfiles/scripts" "$HOME/.local/bin" "/home/marko/.bun/bin" ];
    stateVersion = "21.11";

    packages = with pkgs; [

       # dunst #(dunst.override { dunstify = true; })  # dunstify is installed by default
       simplescreenrecorder
       neovim
       # kitty
       nodePackages.yo
       nodePackages.degit
       haskellPackages.greenclip
       cachix
       exa
       ripgrep
       fd
       fzy
       jq jiq
       #j
       magic-wormhole #Get Things From One Computer To Another, Safely
       nmap
       watch
       fnm
       xsel
       peek

       rofi
       dmenu
       picom
       feh
       i3blocks
       i3status # gives you the default i3 status bar
       i3lock #default i3 screen locker
       i3blocks #if you are planning on using i3blocks over i3status
       hstr
       ugrep
       helix
       tig
       bat
       most 
       sumneko-lua-language-server
       tree-sitter
     ];
  };

  home.sessionVariables = {
    DOTFILES       = "$HOME/dotfiles";
    ZSH_LOC        = "$DOTFILES/zsh";
    FILE 	         = "ranger";
    TERMINAL       = "kitty";
    EDITOR         = "nvim";
    BROWSER        = "google-chrome";
    READER         = "zathura";
    PAGER          = "less";
    WM             = "i3";
    XDG_CONFIG_HOME= "$HOME/.config";
    XDG_DATA_HOME  = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    GIT_EDITOR     = "$EDITOR";
  };

  home.shellAliases = {
    hm = "home-manager";
    at = "atuin";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    fileWidgetCommand = "${pkgs.fd}/bin/fd --type f";
  };
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    baseIndex = 1;
    escapeTime = 0;

     extraConfig = ''
        set -g default-terminal "tmux-256color"        # 24bit color (with italics)
        #set -as terminal-features ",xterm-256color:RGB"
        set -ga terminal-overrides ",xterm-256color:Tc" # Better color support

        set -g mouse on                                 # Enable mouse support (gasp)
        set -gq utf8 on                                 # Set the encoding for the terminal
        set -g status-interval 20                       # Update the status every 20 seconds
     '';
    plugins = with pkgs; [
      # https://github.com/tmux-plugins/tmux-pain-control
      tmuxPlugins.pain-control
      tmuxPlugins.copycat
      tmuxPlugins.sidebar
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'gold'
        '';
      }
      { plugin = tmuxPlugins.yank; }
          tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '${config.xdg.dataHome}/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '20' # minutes
        '';
      }
      # tmuxPlugins.yank
      # tmuxPlugins.fpp
      # tmuxPlugins.open
      # tmuxPlugins.cpu
      ];
      # extraConfig = builtins.readFile ~/dotfiles/tmux.cfg;
  };


  programs.atuin.enable = true;
  programs.atuin.enableZshIntegration = true;

  programs.atuin.settings = {
     dialect = "uk";
     auto_sync = false;
     search_mode = "prefix";
  };

  programs.neovim.enable = false;
  programs.neovim.extraConfig = ''
        :set clipboard+=unnamed
        :set clipboard+=unnamedplus

        let mapleader=" "
        :noremap <leader>gf :e <cfile><cr>
        :noremap <leader>w :silent w<cr>
        nnoremap gp `[v`] " select pasted text

        " Tabs & Indents
        set shiftwidth=4
        set tabstop=4
        set softtabstop=0
        set expandtab
        set scrolloff=5
        set autoindent
        
        set laststatus=3
        highlight WinSeparator guibg=None

        " define a path to store persistent undo files.
        let undo_dir_path = expand('~/.config/vim-persisted-undo/')
        " create the directory and any parent directories
        " if the location does not exist.
        if !isdirectory(undo_dir_path)
            call system('mkdir -p ' . undo_dir_path)
        endif
        " point Vim to the defined undo directory.
        let &undodir = undo_dir_path
        set undolevels=5000
        set undofile
  '';

  programs.neovim.plugins = with pkgs.vimPlugins; [
        vim-sensible
        vim-nix
        vim-unimpaired
        vim-commentary
        vim-surround
  ];

  # Polybar
  services.polybar =  {
    enable = true;
    package = pkgs.polybar.override {
       pulseSupport = true;
       iwSupport = true;
    };
   script = ''
     polybar &
   '';
   settings = {
    "colors" = {
      background = "#121212";
      primary = "#6D0011";
      text = "#F8F8F2";
      grey = "#757575";
      deactivated = "#666666";
    };
    "global/wm" = {
      margin-top = 10;
      margin-bottom = 10;
    };
    "bar/name123" = {
      modules-left = "powermenu spacer ewmh spacer layout";
      modules-right = "input dot battery dot storage dot cpu dot mem dot brightness dot audio dot bluetooth dot wlan dot date spacer launcher";
      width = "100%";
      offset-x = 0;
      offset-y = 0;
      height = 25;
      fixed-center = true;
      bottom = false;
      background = "\${colors.background}";
      foreground = "\${colors.text}";
      radius = 0;
      padding-left = 0;
      padding-right = 0;
      module-margin-left = 0;
      module-margin-right = 0;
      separator = "";
      font-0 = "BlexMono Nerd Font:size=8;3";
      border-bottom = 2;
      border-color = "\${colors.primary}";
      cursor-click = "pointer";
      cursor-scroll = "ns-resize";
      line-size = 2;
      line-color = "\${colors.primary}";
      tray-position = "none";
    };
    "module/volume" = {
        type = "internal/pulseaudio";
        format.volume = "<ramp-volume> <label-volume>";
        label.muted.text = "🔇";
        label.muted.foreground = "#666";
        ramp.volume = ["🔈" "🔉" "🔊"];
        click.right = "pavucontrol &";
      };
   };
  };

  services.espanso.enable = true;
  services.dunst.enable = true;

  systemd.user = {
    services = {
      dunst = {
        Unit = {
          After = ["graphical.target"];
        };
        Service = {
          # ExecStart = "${pkgs.dunst}/bin/dunst";
          Restart = "on-failure";
          RestartSec = 2;
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
      espanso = {
        Unit = {
          Description = "Espanso: cross platform text expander in Rust";
          Documentation = "https://github.com/federico-terzi/espanso/";
          After = ["graphical.target"];
        };
        Service = {
          Type = "exec";
          # ExecStart = "${pkgs.espanso}/bin/espanso daemon";
          ExecReload= "/usr/bin/kill -SIGUSR1 $MAINPID";
          Restart = "on-failure";
          RestartSec = "5";
        };
        Install = {
          WantedBy = ["default.target"];
        };
      };
    };
  };


  services.espanso.settings = {
       matches = [
         { trigger = ";slow"; replace = "let startTime = performance.now();\nwhile (performance.now() - startTime < 500) {}";}
         { trigger = ";ram"; replace = "grid-template-columns: repeat(auto-fill, minmax(min(150px, 100%), 1fr));"; }
         { trigger = ";details"; replace = "<details>\n<summary> </summary>\n\n</details>\n";}
         { trigger = ";prtitle"; replace = "feat(<CONTEXT>): <DESC>";}
         { trigger = ";meat"; replace = "http://app.frischfleisch.meatico.local:3000"; }
         { trigger = ";email"; replace = "crashxx@gmail.com"; }
         { trigger = ";wmail"; replace = "marko@deep-impact.ch"; }
         { trigger = ";addr"; replace = "Schaffhauserstrasse";}
         { trigger = ";city"; replace = "Winterthur";}
         { trigger = ";phone"; replace = "0772454888";}
         { trigger = ";pen"; replace="https://codepen.io/pen?template=eYMzpeO";}

         { # Simple text replacement
           trigger = ":espanso"; replace = "Hi there!"; }
         { # Dates
           trigger = ";date";
           replace = "{{mydate}}";
           vars = [{
             name = "mydate";
             type = "date";
             params = { format = "%m/%d/%Y"; };
           }];
         }
         { # Shell commands
           trigger = ";rmail";
           replace = "joe{{random}}@gmail.com";
           vars = [{
             name = "random";
             type = "shell";
             params = { cmd = "echo $RANDOM | base64 | head -c 10; echo"; };
           }];
         }
       ];
     };

  programs.mcfly.enable = true;
  programs.mcfly.enableFuzzySearch = true;
  programs.mcfly.enableZshIntegration = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.just = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.bash.enable = true;
  programs.exa.enable = true;

  programs.zsh = { 
  	enable = true;
        initExtra = builtins.readFile ~/dotfiles/zsh/.zshrc;
  };
}
