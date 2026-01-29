#!/bin/bash
#
# Convert all LilyPond files to SVG, WebP, MIDI, WAV, Opus, and WebM
#

# Exit on error
set -xeuo pipefail
IFS=$'\n\t'

SOUNDFONT='FluidR3_GM.sf2'

for ly_file in ${1:-*}/*.ly; do
  # File path without extension
  file="${ly_file%.ly}"

  # Convert LilyPond to SVG and MIDI
  lilypond --loglevel=WARNING -dwarning-as-error \
    --svg -dno-point-and-click -dmidi-extension=mid \
    --output="$file" "$file.ly"

  # Optimize SVG
  npx svgo --quiet "$file.svg"

  # Convert SVG to WebP with white background
  rsvg-convert --width=2160 --background-color=white \
    --output="$file.webp" "$file.svg"

  # Set SVG background to white
  ./svg-bg.js "$file.svg"

  # Format SVG
  xmllint --format --encode UTF-8 --output "$file.svg" "$file.svg"

  # Convert MIDI to WAV
  fluidsynth --quiet --fast-render="$file.wav" "$SOUNDFONT" "$file.mid"

  # Convert WAV to Opus
  ffmpeg -y -loglevel error -i "$file.wav" -codec:a libopus "$file.opus"

  # Convert Opus to WebM
  ffmpeg -y -loglevel error \
    -f lavfi -i 'color=color=black:size=256x144' -i "$file.opus" \
    -codec:v libvpx-vp9 -codec:a libopus \
    -filter:a 'silenceremove=stop_periods=1:stop_threshold=-50dB' \
    -shortest -pix_fmt yuv420p "$file.webm"
done
