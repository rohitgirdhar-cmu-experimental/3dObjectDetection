import sys, os
import numpy as np
import cv2

#scoredir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune_onlypos/'
scoredir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune/'
imgsdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/JPEGImages/'
selboxdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/nyu_selsearch_boxes_txt/'
outdir = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Vis/finetune_with3D/'
testNdxs_file = '/srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Splits/testNdxs.txt'

f = open(testNdxs_file)
testNdxs = [int(el) for el in f.read().splitlines()]
f.close()

clses =  ['bed', 'chair', 'mtv', 'sofa', 'table']

for CLS in range(1, len(clses) + 1):
  clsoutdir = os.path.join(outdir, clses[CLS - 1])
  try:
    os.makedirs(clsoutdir)
  except:
    pass
  for img in testNdxs:
    boxes = np.loadtxt(os.path.join(selboxdir, str(img) + '.txt'),
        delimiter=',')
    outfpath = os.path.join(os.path.join(clsoutdir, str(img) + '.txt'))

    fpath = os.path.join(scoredir, str(img) + '.txt')
    f = open(fpath)
    lines = f.read().splitlines()
    f.close()

    #I = cv2.imread(os.path.join(imgsdir, sys.argv[1] + '.jpg'))

    i = 0
    f = open(outfpath, 'w')
    for line in lines:
      elts = [float(el) for el in line.split()]
      order = np.argsort(np.array(elts))
      if order[-1] == CLS:
        box = [(int(boxes[i][1]), int(boxes[i][0])), (int(boxes[i][3]), int(boxes[i][2]))]
        f.write('%f %f %f %f\n' % (boxes[i][1], boxes[i][0], boxes[i][3], boxes[i][2]))
        # cv2.rectangle(I, box[0], box[1], (255,0,0), 2)
      i += 1
    f.close()
    # cv2.imwrite("temp.jpg", I)
