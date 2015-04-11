import sys, os
import numpy as np
import cv2

outdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune_onlypos/'
outdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune/'
imgsdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/JPEGImages/'
selboxdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/nyu_selsearch_boxes_txt/'

clses =  ['bed', 'chair', 'mtv', 'sofa', 'table']
CLS = 2

boxes = np.loadtxt(os.path.join(selboxdir, sys.argv[1] + '.txt'),
    delimiter=',')

fpath = os.path.join(outdir, sys.argv[1] + '.txt')
f = open(fpath)
lines = f.read().splitlines()
f.close()
drawboxes = []

I = cv2.imread(os.path.join(imgsdir, sys.argv[1] + '.jpg'))

i = 0
for line in lines:
  elts = [float(el) for el in line.split()]
  order = np.argsort(np.array(elts))
  if order[-1] == CLS:
    box = [(int(boxes[i][1]), int(boxes[i][0])), (int(boxes[i][3]), int(boxes[i][2]))]
    cv2.rectangle(I, box[0], box[1], (255,0,0), 2)
  i += 1
cv2.imwrite("temp.jpg", I)
