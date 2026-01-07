#!/usr/bin/env python3
import sys
import xml.etree.ElementTree as ET

input_filename = sys.argv[1]

ET.register_namespace('', 'http://www.w3.org/2000/svg')
ET.register_namespace('xlink', 'http://www.w3.org/1999/xlink')

dom = ET.parse(input_filename)
svg = dom.getroot()
svg.insert(0, ET.fromstring('<rect width="100%" height="100%" fill="#ffffff"/>'))
dom.write(input_filename)
