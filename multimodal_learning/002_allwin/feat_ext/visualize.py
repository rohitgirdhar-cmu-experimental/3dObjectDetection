import sys, os
import numpy as np
import Image, ImageDraw

outdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune_onlypos/'
outdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune/'
imgsdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/JPEGImages/'
selboxdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/nyu_selsearch_boxes_txt/'

boxes = np.loadtxt(os.path.join(selboxdir, sys.argv[1] + '.txt'),
    delimiter=',')

fpath = os.path.join(outdir, sys.argv[1] + '.txt')
f = open(fpath)
lines = f.read().splitlines()
f.close()
drawboxes = []

I = Image.open(os.path.join(imgsdir, sys.argv[1] + '.jpg'))
draw = ImageDraw.Draw(I)

i = 0
for line in lines:
  elts = [float(el) for el in line.split()]
  order = np.argsort(np.array(elts))
  if order[-1] == 5:
    box = [(boxes[i][1], boxes[i][0]), (boxes[i][3], boxes[i][2])]
    draw.rectangle(box)
  i += 1
I.save("temp.png", "PNG")
