function out = run_eval()
featdir = '~/Work/Projects/002_GeoObjDet/data/Features/nyu_finetune';
selboxdir = '~/Work/Projects/002_GeoObjDet/data/nyu_selsearch_boxes_txt/';
imdb = imdb_from_nyu('test');
classes = {'bg', 'bed', 'chair', 'mtv', 'sofa', 'table'};
cls_to_eval = 2;

outputs = {};
for i = 1 : numel(imdb.image_ids)
  i
  imgid = imdb.image_ids{i};
  boxes = dlmread(fullfile(selboxdir, [imgid '.txt']));
  boxes = boxes(:, [2 1 4 3]);
  fpath = fullfile(featdir, [imgid '.txt']);
  out = dlmread(fpath);
  [~, cls] = max(out, [], 2);
  outputs{i} = boxes(cls == cls_to_eval, :);
end
out = imdb_eval_nyu(classes{cls_to_eval}, outputs, imdb);
