#!/usr/bin/env python3
import sys
import xml.etree.ElementTree as ET

dom = ET.parse(sys.argv[1])
svg = dom.getroot()
svg.insert(0, ET.fromstring('<rect width="100%" height="100%" fill="#ffffff"/>'))
