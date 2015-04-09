CODE_PATH=/home/rgirdhar/data/Work/Code/0001_FeatureExtraction/ComputeFeatures/Features/CNN/ver2/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CODE_PATH}/../external/caffe/build/lib/
GLOG_logtostderr=1 ${CODE_PATH}/computeFeatures.bin \
    -i /srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/JPEGImages/ \
    -q /srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/ImgsList.txt \
    -n /srv2/rgirdhar/Work/Code/0004_GeoObjDet/multimodal_learning/003_rcnn_nyu_posonly/nyu_finetune_deploy.prototxt \
    -m /srv2/rgirdhar/Work/Code/0004_GeoObjDet/multimodal_learning/003_rcnn_nyu_posonly/models/finetune_nyu_train_iter_90000.caffemodel \
    -l output \
    -o /srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/Features/nyu_finetune_onlypos \
    -w /srv2/rgirdhar/Work/Code/0004_GeoObjDet/data/nyu_selsearch_boxes_txt \
    -t text
