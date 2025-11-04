{ pkgs, lib, anti-ip, ... }:

{
  home.packages = (with pkgs; [
    legcord
    libreoffice
    mpv
    nixd
    qbittorrent
    tor-browser
    ungoogled-chromium
    octaveFull
    vlc
  ]) ++ (with pkgs.gnomeExtensions; [ appindicator system-monitor ]);

  fonts.fontconfig.enable = true;

  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "org.prismlauncher.PrismLauncher"
      "com.usebottles.bottles"

    ];
  };

  dconf.settings = lib.mkMerge [{
    "org/gnome/shell" = {
      enabled-extensions = map (extension: extension.extensionUuid)
        (with pkgs.gnomeExtensions; [ appindicator system-monitor ]);
      disabled-extensions = [ ];
    };
  }];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default.extensions = (with pkgs.vscode-extensions; [
      mkhl.direnv
      jnoortheen.nix-ide
      sumneko.lua
      tomoki1207.pdf
      teabyii.ayu
    ]) ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "gitless";
      publisher = "maattdd";
      version = "11.7.2";
      sha256 = "sha256-rYeZNBz6HeZ059ksChGsXbuOao9H5m5lHGXJ4ELs6xc=";
    }]);
    profiles.default.userSettings = {
      "git.enableSmartCommit" = true;
      "window.menuBarVisibility" = "toggle";
      "window.autoDetectColorScheme" = true;
      "workbench.panel.defaultLocation" = "right";
      "editor.inlineSuggest.enabled" = true;
      "git.autofetch" = true;
      "gitlens.telemetry.enabled" = false;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "direnv.restart.automatic" = true;
      "[nix]".editor.formatOnSave = true;
      "diffEditor.ignoreTrimWhitespace" = false;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "workbench.preferredDarkColorTheme" = "Red";
      "workbench.colorTheme" = "Red";
    };
  };
}

