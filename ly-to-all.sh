#!/bin/bash
#
# Convert all LilyPond files in each directory to SVG, MIDI, WebM, and MusicXML.
#
# Prerequisites:
#
# - lilypond
# - librsvg
# - fluidsynth
# - FluidR3_GM.sf2
# - ffmpeg
# - python3
# - python-ly
#

# Exit immediately if any command fails.
set -xeuo pipefail
IFS=$'\n\t'

SOUNDFONT='FluidR3_GM.sf2'

for ly in */*.ly; do
  input="${ly%.ly}"

  # Convert LilyPond to SVG and MIDI
  lilypond --svg -dcrop -dmidi-extension=mid "$input.ly"
  mv "$input.cropped.svg" "$input.svg"

  # Set SVG background to white
  rsvg-convert -b white -f svg -o "$input.svg" "$input.svg"

  # Convert MIDI to WAV
  fluidsynth -ni "$SOUNDFONT" "$input.mid" -F "$input.wav"

  # Convert WAV to WebM
  ffmpeg -y -f lavfi -i 'color=c=black:s=320x180' -i "$input.wav" \
    -c:v libvpx-vp9 -c:a libopus \
    -af 'silenceremove=stop_periods=1:stop_threshold=-50dB' \
    -shortest -pix_fmt yuv420p \
    "$input.webm"

  rm "$input.wav"

  # Convert LilyPond to MusicXML (extract only `\relative` block)
  python3 -c '
    import re, sys
    score = open(sys.argv[1]).read()
    print(re.search(r"\\relative.*?{.*?}", score, re.DOTALL).group(0))
  ' "$input.ly" \
    | ly musicxml -d 'backup-suffix=' -o "$input.musicxml"
done
