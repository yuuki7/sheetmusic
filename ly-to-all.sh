#!/bin/sh
soundfont="$HOME/Library/Audio/Sounds/Banks/FluidR3_GM.sf2"
input="${1%.ly}"

# Exit on error
set -e

# Convert LilyPond to SVG and MIDI
lilypond --svg -dcrop -dmidi-extension=mid "$input.ly"
mv "$input.cropped.svg" "$input.svg"

# Set the SVG background to white
rsvg-convert -b white -f svg -o "$input.svg" "$input.svg"

# Convert MIDI to WAV
fluidsynth -ni "$soundfont" "$input.mid" -F "$input.wav"

# Convert WAV to WebM
ffmpeg -y -f lavfi -i 'color=c=black:s=320x180' -i "$input.wav" -c:v libvpx-vp9 -c:a libopus -af 'silenceremove=stop_periods=1:stop_threshold=-50dB' -shortest -pix_fmt yuv420p "$input.webm"

rm "$input.wav"

# Convert LilyPond to MusicXML (extracting only the `\relative` block)
python3 -c 'import re, sys; print(re.search(r"\\relative.*?{.*?}", open(sys.argv[1]).read(), re.DOTALL).group(0))' "$input.ly" \
| ly musicxml -d 'backup-suffix=' -o "$input.musicxml"
