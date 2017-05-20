#!/usr/bin/env python

import pyclipper
import re
import sys
import xml.etree.ElementTree as ET

def process_path(path_array, paths):
    current_path = []
    for element in path_array:
        if element == 'M':
            if current_path != []:
                paths.append(current_path)
            current_path = []
            continue
        elif element == 'L':
            continue
        m = re.match('([\-0-9\.]+),([\-0-9\.]+)', element)
        if m:
            current_path.append((float(m.group(1)), float(m.group(2))))
    if current_path != []:
        paths.append(current_path)

def offset(path, amount):
    pco = pyclipper.PyclipperOffset()
    pco.AddPath(path, pyclipper.JT_ROUND, pyclipper.ET_CLOSEDPOLYGON)
    solution = pco.Execute(amount)
    # TODO: Needs to be scaled so Clipper can use integers
    print("Outset version: %r"%solution)
    
def main():
    filename = sys.argv[1]
    with open(filename, "rt") as f:
        xmltext = f.read()
    tree = ET.parse(filename)
    root = tree.getroot()
    paths = []
    for child in root:
        tag = re.sub('^\{[^\}]*\}', "", child.tag, count=1)
        print(tag)
        if tag == "path":
            path = child.attrib['d'].strip().split(" ")
            process_path(path, paths)
    for p in paths:
        for point in p:
            for exterior_polygon in paths:
                if point_inside_polygon(p, exterior_polygon):
                    # This polygon is interior
                    print("\nInterior path: %r"%p)
                    offset(p,-1.0)
                    
                else:
                    # This polygon is exterior
                    print("\nExterior path: %r"%p)
                    offset(p, 1.0)
if __name__ == "__main__":
    main()
