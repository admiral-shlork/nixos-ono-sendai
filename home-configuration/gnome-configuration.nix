{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab  {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
  ];

  dconf.settings = {
    # Enable location
    "org/gnome/system/location" = {
      enabled = true;
      max-accuracy-level = "exact";
    };
    # Nautilus preferences
    "org/gnome/nautilus/preferences" = {
      date-time-format = "datailed";
      default-folder-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };
    "org/gnome/nautilus/icon-view" = {
      captions = [ "size" "type" "none" ];
    };
    "org/gnome/nautilus/list-view" = {
      default-column-order = [ "name" "size" "type" "owner" "group" "permissions" "date_modified" "date_accessed" "date_created" "recency" "detailed_type" ];
      default-visible-columns = [ "name" "size" "type" "owner" "group" "permissions" "date_modified"] ;
      use-tree-view = true;
    };
    # Desktop background
    "org/gnome/desktop/background" = {
      picture-options = "none";
      primary-color = "#000000";
    };
    # Disable lock screen notifications
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    # Show weekday in calendar
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    # Titlebar customisation, set number of workspaces to 1
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close:appmenu";
      action-right-click-titlebar = "minimize";
      action-middle-click-titlebar = "lower";
      num-workspaces = 1;
    };
    # Enable active edges for window tiling
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    # Enable nightlight
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    # Power settings
    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "interactive";
      power-saver-profile-on-low-battery = false;
      sleep-inactive-ac-timeout = 900;
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-timeout = 1800;
      sleep-inactive-battery-type = "suspend";
    };
    # Keyboard bindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
      screensaver = [ "<Control><Super>q" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "/run/current-system/sw/bin/nautilus --new-window";
      name = "Nautilus";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>w";
      command = "ghostty";
      name = "Ghostty";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "Print";
      command = "/etc/profiles/per-user/whatever/bin/gnome-screenshot --interactive";
      name = "Screenshot";
    };
    "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [];
        toggle-application-view = [ "<Super>space" ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Alt><Super>j" ];
      toggle-tiled-right = [ "<Alt><Super>l" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Alt><Super>k" ];
    };
    # Enabled extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        caffeine.extensionUuid
        dash-to-panel.extensionUuid
        date-menu-formatter.extensionUuid
        night-theme-switcher.extensionUuid
        no-overview.extensionUuid
      ];
    };
    # Dash-to-panel extension preferences
    # "org/gnome/shell/extensions/dash-to-panel" = {
    #   appicon-margin = 3;
    #   appicon-padding = 1;
    #   panel-positions = "{\"0\":\"RIGHT\"}";
    #   panel-element-positions = ''
    #   {"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"}]}
    #   '';
    #   dot-position = "BOTTOM";
    #   dot-style-focused = "SQUARES";
    #   dot-style-unfocused = "SQUARES";
    #   scroll-icon-action = "PASS_THROUGH";
    #   scroll-panel-action = "CHANGE_VOLUME";
    #   trans-panel-opacity = 0.00;
    #   trans-use-custom-opacity = true;
    # };
    # Date-menu-formatter preferences
    "org/gnome/shell/extensions/date-menu-formatter" = {
      pattern = "dd\nMM\nyy\nE\nHH\nmm\nss";
      text-align = "right";
      update-level = "2";
    };
    # Caffeine preferences
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = "2";
      restore-state = true;
      show-indicator = "always";
      show-notifications = false;
    };
    # Disable natural scrolling on a trackpoint and enable two finger scrolling
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enable = true;
      natural-scroll = false;
    };
    # Fractional scaling in Gnome
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };  
}
