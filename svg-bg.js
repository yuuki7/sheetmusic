#!/usr/bin/env node
//
// Set SVG background to white
//
import { readFileSync, writeFileSync } from 'node:fs';
import { argv } from 'node:process';

import { DOMParser, XMLSerializer } from '@xmldom/xmldom';

// Read SVG file
const svgFile = argv[2];
const svgSource = readFileSync(svgFile, 'utf8');

// Parse SVG source
const doc = new DOMParser().parseFromString(svgSource, 'image/svg+xml');

// Insert white rectangle
const svg = doc.documentElement;
const rect = doc.createElementNS('http://www.w3.org/2000/svg', 'rect');
rect.setAttribute('width', '100%');
rect.setAttribute('height', '100%');
rect.setAttribute('fill', '#fff');
svg.insertBefore(rect, svg.firstChild);

// Serialize to XML
const xml = new XMLSerializer().serializeToString(doc);

// Write back to file
writeFileSync(svgFile, xml, 'utf8');
