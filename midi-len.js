#!/usr/bin/env node
//
// Get MIDI duration
//
import { readFileSync } from 'node:fs';
import { argv } from 'node:process';

// import { Midi } from '@tonejs/midi';
// XXX: workaround for "CommonJS modules can always be imported via the default export"
// error in @tonejs/midi v2.0.28
import pkg from '@tonejs/midi';
const { Midi } = pkg;

// Read MIDI file
const midiFile = argv[2];
const midiData = readFileSync(midiFile);

// Parse MIDI and output duration
const midi = new Midi(midiData);
console.log(midi.duration);
