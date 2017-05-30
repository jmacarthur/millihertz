#!/usr/bin/env python

import pyclipper
import re
import sys
import xml.etree.ElementTree as ET


polygon_id = 0

class Polygon(object):
    def __init__(self, point_list = []):
        global polygon_id
        self.path = point_list
        self.interior = False
        self.id = polygon_id
        polygon_id += 1

def process_path(path_array, poly_list):
    current_path = []
    for element in path_array:
        if element == 'M':
            if current_path != []:
                poly_list.append(Polygon(current_path))
            current_path = []
            continue
        elif element == 'L':
            continue
        m = re.match('([\-0-9\.]+),([\-0-9\.]+)', element)
        if m:
            current_path.append((float(m.group(1)), float(m.group(2))))
    if current_path != []:
        poly_list.append(Polygon(current_path))

def offset(path, amount):
    pco = pyclipper.PyclipperOffset()
    pco.AddPath(path, pyclipper.JT_ROUND, pyclipper.ET_CLOSEDPOLYGON)
    solution = pco.Execute(amount)
    # TODO: Needs to be scaled so Clipper can use integers
    print("Outset version: %r"%solution)

def closePolygon(path):
    if path[0] != path[-1]: path.append(path[0])

def findInterior(polygon, polys):
    for point in polygon.path:
        for exterior_polygon in polys:
            if exterior_polygon == polygon: continue
            if pyclipper.PointInPolygon(point, exterior_polygon.path) == 1:
                print("Polygon %d is inside polygon %d"%(polygon.id, exterior_polygon.id))
                polygon.interior = True
                return

def extents(polygon):
    minx = maxx = polygon.path[0][0]
    miny = maxy = polygon.path[0][1]
    for point in polygon.path:
        if point[0]>maxx: maxx = point[0]
        if point[0]<minx: minx = point[0]
        if point[1]>maxy: maxy = point[1]
        if point[1]<miny: miny = point[1]
    return (minx, miny, maxx, maxy)
    
def main():
    filename = sys.argv[1]
    with open(filename, "rt") as f:
        xmltext = f.read()
    tree = ET.parse(filename)
    root = tree.getroot()
    polys = []
    for child in root:
        tag = re.sub('^\{[^\}]*\}', "", child.tag, count=1)
        print(tag)
        if tag == "path":
            path = child.attrib['d'].strip().split(" ")
            process_path(path, polys)

    # Dump polygon details
    for p in polys:
        (minx, miny, maxx, maxy) = extents(p)
        print("Polygon %d: from (%d,%d) to (+%d,+%d), Orient: %s"%(p.id, minx, miny, maxx-minx, maxy-miny, "Outer" if pyclipper.Orientation(p.path) else "Inner" ))

    for p in polys:
        if pyclipper.Orientation(p.path):
            # This polygon is interior
            print("\nInterior path: %r"%p)
            offset(p.path,-1.0)
        else:
            # This polygon is exterior
            print("\nExterior path: %r"%p)
            offset(p.path, 1.0)

if __name__ == "__main__":
    main()
