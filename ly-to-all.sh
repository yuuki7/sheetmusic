#!/bin/bash
#
# Convert all LilyPond files to SVG, MIDI, WAV, and WebM
#

# Exit on error
set -xeuo pipefail
IFS=$'\n\t'

SOUNDFONT='FluidR3_GM.sf2'

for ly_file in ${1:-*}/*.ly; do
  # File path without extension
  file="${ly_file%.ly}"

  # Convert LilyPond to SVG and MIDI
  lilypond --loglevel=WARNING --svg -dcrop -dmidi-extension=mid \
    --output="$file" "$file.ly"

  mv "$file.cropped.svg" "$file.svg"

  # Set SVG background to white
  rsvg-convert --background-color=white --format=svg \
    --output="$file.svg" "$file.svg"

  # Format SVG
  xmllint --format --encode UTF-8 --output "$file.svg" "$file.svg"

  # Convert MIDI to WAV
  fluidsynth --quiet --fast-render="$file.wav" "$SOUNDFONT" "$file.mid"

  # Convert WAV to WebM
  ffmpeg -y -loglevel error \
    -f lavfi -i 'color=color=black:size=320x180' -i "$file.wav" \
    -codec:v libvpx-vp9 -codec:a libopus \
    -filter:a 'silenceremove=stop_periods=1:stop_threshold=-50dB' \
    -shortest -pix_fmt yuv420p "$file.webm"
done
