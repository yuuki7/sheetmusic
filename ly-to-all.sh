#!/bin/bash
#
# Convert all LilyPond files to SVG, WebP, MIDI, WAV, Opus, and WebM
#
# Prerequisites:
#
# - lilypond 2.24.4
# - librsvg 2.61.3
# - libxml2 2.15.1
# - fluidsynth 2.5.2
# - FluidR3_GM.sf2
# - ffmpeg 8.0.1
# - node 25.5.0 (and npm dependencies)
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

  # Get MIDI duration
  duration=$(./midi-len.js "$file.mid")

  # Trim WAV
  ffmpeg -loglevel error -i "$file.wav" -t "$duration" "$file.tmp.wav"
  mv "$file.tmp.wav" "$file.wav"

  # Convert WAV to Opus
  ffmpeg -y -loglevel error -i "$file.wav" -codec:a libopus "$file.opus"

  # Convert Opus to WebM
  ffmpeg -y -loglevel error \
    -f lavfi -i 'color=color=black:size=256x144' -i "$file.opus" \
    -codec:v libvpx-vp9 -codec:a copy \
    -t "$duration" -pix_fmt yuv420p "$file.webm"
done
