{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    escapeTime = 10;
    keyMode = "vi";
    baseIndex = 1;
    resizeAmount = 10;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-bind "o"
        '';
      }
      continuum
      resurrect
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"

          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_status_background "none"


          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "

          # Setting left and right sides of tmux
          # If not cleaned - can spaws same stuff on reload
          set -g status-left ""
          set -ag status-left "#{E:@catppuccin_status_session}"

          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_date_time}"

          set -g @catppuccin_pane_status_enabled "no"
          set -g @catppuccin_status_fill "icon"

          ## Window status configuration
          set -g @catppuccin_window_text ""
          set -g @catppuccin_window_number "#[fg=#{@thm_mauve},bg=default]  #I  #[bg=default]"
          set -g @catppuccin_window_fill "number"
          set -g @catppuccin_window_left_separator "#[fg=#{@thm_mauve},bg=default]#[bg=default]"
          set -g @catppuccin_window_right_separator "#[fg=#{@thm_mauve},bg=default]#[bg=default]"
          set -g @catppuccin_window_middle_separator ""

          ## Window current configuration
          set -g @catppuccin_window_current_text ""
          set -g @catppuccin_window_current_number "#[fg=#{@thm_mauve},bg=default,reverse]  #I  #[none]"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_left_separator "#[fg=#{@thm_mauve},bg=default] #[none]"
          set -g @catppuccin_window_current_right_separator "#[fg=#{@thm_mauve},bg=default] #[none]"
          set -g @catppuccin_window_current_middle_separator ""
        '';
      }
    ];
    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -g renumber-windows on
      set -g set-titles on


      set -g status-bg default
      set -g status-style bg=default
      set -g default-command "nu"


      unbind '"'
      bind "|" split-window -h
      unbind %
      bind "_" split-window -v

      bind > swap-pane -D       # swap current pane with the next one
      bind < swap-pane -U       # swap current pane with the previous one

      bind -r H resize-pane -L 10
      bind -r J resize-pane -D 10
      bind -r K resize-pane -U 10
      bind -r L resize-pane -R 10

      bind C-c run "tmux save-buffer - | xclip -i -sel clip"
      bind C-v run "tmux set-buffer $(xclip -o -sel clip); tmux paste-buffer"

      set -g status-position top
      set -g status 2

      set -g status-format[1] ""

      # Smart Splits keybind
      bind-key -n C-h if -F "#{@pane-is-vim}" 'send-keys C-h'  'select-pane -L'
      bind-key -n C-j if -F "#{@pane-is-vim}" 'send-keys C-j'  'select-pane -D'
      bind-key -n C-k if -F "#{@pane-is-vim}" 'send-keys C-k'  'select-pane -U'
      bind-key -n C-l if -F "#{@pane-is-vim}" 'send-keys C-l'  'select-pane -R'

      bind-key -n M-h if -F "#{@pane-is-vim}" 'send-keys M-h' 'resize-pane -L 3'
      bind-key -n M-j if -F "#{@pane-is-vim}" 'send-keys M-j' 'resize-pane -D 3'
      bind-key -n M-k if -F "#{@pane-is-vim}" 'send-keys M-k' 'resize-pane -U 3'
      bind-key -n M-l if -F "#{@pane-is-vim}" 'send-keys M-l' 'resize-pane -R 3'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if -F \"#{@pane-is-vim}\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if -F \"#{@pane-is-vim}\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };
}
