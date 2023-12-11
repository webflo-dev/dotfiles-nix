{ pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.etc = {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 44100
        default.clock.quantum = 512
        default.clock.min-quantum = 512
        default.clock.max-quantum = 512
      }
    '';
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
    pulseaudio-ctl
    pulsemixer
  ];

}
