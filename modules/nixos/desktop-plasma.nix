{ pkgs, ... }:

let
  applyPlasmaSettings = pkgs.writeShellScript "apply-plasma-settings" ''
    ${pkgs.kdePackages.plasma-workspace}/bin/plasma-apply-colorscheme BreezeDark

    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 \
      --file kcminputrc \
      --group Libinput \
      --group 10248 \
      --group 546 \
      --group "FTCS1000:00 2808:0222 Touchpad" \
      --key NaturalScroll \
      --type bool \
      --notify \
      true

    # KWin does not apply kcminputrc changes when /KWin.reconfigure is called.
    # Set the property on every live touchpad as well so it takes effect in the
    # current Wayland session.
    ${pkgs.systemd}/bin/busctl --user tree org.kde.KWin --list \
      | while read -r device; do
          case "$device" in
            /org/kde/KWin/InputDevice/*)
              if [ "$(${pkgs.systemd}/bin/busctl --user get-property \
                org.kde.KWin "$device" org.kde.KWin.InputDevice touchpad \
                2>/dev/null)" = "b true" ]; then
                ${pkgs.systemd}/bin/busctl --user set-property \
                  org.kde.KWin "$device" org.kde.KWin.InputDevice \
                  naturalScroll b true
              fi
              ;;
          esac
        done

    # Disable KWin's "Zoom" effect.
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 \
      --file kwinrc \
      --group Plugins \
      --key zoomEnabled \
      --type bool \
      --notify \
      false

    ${pkgs.systemd}/bin/busctl --user call \
      org.kde.KWin /KWin org.kde.KWin reconfigure
  '';
in
{
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.printing.enable = true;

  services.libinput.touchpad.naturalScrolling = true;

  systemd.user.services.plasma-session-settings = {
    description = "Apply declarative Plasma session settings";
    wantedBy = [ "plasma-workspace.target" ];
    after = [ "plasma-kwin_wayland.service" ];
    unitConfig.ConditionUser = "adam";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = applyPlasmaSettings;
    };
  };
}
