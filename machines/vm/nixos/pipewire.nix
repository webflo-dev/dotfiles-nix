{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
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
    "pipewire/pipewire.conf.d/10-echo-cancellation.conf".text = ''
       context.modules = [
        {   name = libpipewire-module-echo-cancel
            args = {
                # library.name  = aec/libspa-aec-webrtc
                # node.latency = 1024/48000
                source.props = {
                   node.name = "Echo Cancellation Source"
                }
                sink.props = {
                   node.name = "Echo Cancellation Sink"
                }
            }
        }
      ]
    '';
    "pipewire/pipewire.conf.d/99-denoising.conf.disable".text = ''
      context.modules = [
      {   name = libpipewire-module-filter-chain
          args = {
              node.description =  "Noise Canceling source"
              media.name =  "Noise Canceling source"
              filter.graph = {
                  nodes = [
                      {
                          type = ladspa
                          name = rnnoise
                          plugin = librnnoise_ladspa
                          label = noise_suppressor_stereo
                          control = {
                              "VAD Threshold (%)" 85.0
                              "VAD Grace Period (ms)" 200
                              "Retroactive VAD Grace (ms)" 0
                          }
                      }
                  ]
              }
              capture.props = {
                  node.name =  "capture.rnnoise_source"
                  node.passive = true
                  audio.rate = 48000
              }
              playback.props = {
                  node.name =  "rnnoise_source"
                  media.class = Audio/Source
                  audio.rate = 48000
              }
          }
      }
      ]
    '';
  };

}
