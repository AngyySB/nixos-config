{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  hardware.alsa.enablePersistence = true;

  # Default 4 KiB ALSA sequencer MIDI buffers overrun on large SysEx dumps
  # (e.g. Novation Components sending packs to Circuit Tracks via Chromium).
  boot.extraModprobeConfig = ''
    options snd-seq-midi output_buffer_size=65536 input_buffer_size=65536
  '';
}
