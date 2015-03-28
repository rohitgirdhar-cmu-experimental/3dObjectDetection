
%% This code doesn't work yet.. try the rcnn code
function genImgsAndLabs(images, labels)
normalsdir = '/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals';
vocab = load('vocab.mat');
if nargin == 0
    load('nyu_depth_v2_labeled.mat');
end
load('splits.mat');

% names = {'bed', 'chair', 'mtv', 'sofa', 'table'};
ids = {[157], [5], [49, 172], [83], [19]};
myids = {[1], [2], [3], [4], [5]};

imgsdir = 'dataset/NYU/JPEGImages';
labelsdir = 'Labels';
DEBUG = 0;

load('nyu_selsearch_boxes.mat', 'boxes');
fid = fopen(fullfile(labelsdir, 'nyu_windows.txt'), 'w');
for i = 1 : size(images, 4) 
  fprintf(2, 'Doing for %d\n', i);
  I = images(:, :, :, i);
  N = getNormalsData(normalsdir, i);
  label = labels(:, :, i);
  thisimname = fullfile(imgsdir, [num2str(i) '.jpg']);
  fprintf(fid, '%s\n', thisimname);
  for j = 1 : numel(myids)
    gtboxes = getObjDets(label, ids{j});
    keyboard
    gtboxes = gtboxes([2 1 4 3]);
    selboxes = boxes{i};
    selboxes = selboxes([2 1 4 3]);
    ovs = computeOverlaps(selboxes, gtboxes);
    bboxes(:, :) = int32(bboxes);
    for k = 1 : size(selbboxes, 1)
      % Ignore too small bounding boxes
      if selboxes(k, 3) < 30 || selboxes(k, 4) < 30
        continue
      end
      clip = I(selboxes(k, 1) : selboxes(k, 1) + selboxes(k, 3), selboxes(k, 2) : selboxes(k, 2) + selboxes(k, 4), :);
      clipN = N(selboxes(k, 1) : selboxes(k, 1) + selboxes(k, 3), selboxes(k, 2) : selboxes(k, 2) + selboxes(k, 4), :);
      clipIdx = quantizeNormals(clipN, vocab);
      if DEBUG
        imwrite(imresize(unquantizeNormals(idx, vocab), 10), fullfile('temp', thisimname));
      end
      ov = max(ovs(j, :));
      fprintf(fid, '%d %f %f %f %f %f', cls, ov, selboxes(k, 1), selboxes(k, 2),...
          selboxes(k, 3), selboxes(k, 4));
%      for p = 1 : numel(idx)
%        fprintf(fid, '%d ', clipIdx(p));
%      end
      fprintf(fid, '\n');
    end
  end
end
fclose(fid);

function bboxes = getObjDets(labelImg, ids)
bboxes = zeros(0, 4);
for id = ids(:)'
    r = regionprops(labelImg == id, 'BoundingBox');
    thisbbxs = cat(1, r.BoundingBox);
    if size(thisbbxs, 1) >= 1
        bboxes(end + 1 : end + size(thisbbxs, 1), :) = thisbbxs;
    end
end

function [N] = getNormalsData(normalsdir, imid)
load(fullfile(normalsdir, ['nm_' sprintf('%06d', imid) '.mat']), 'nx', 'ny', 'nz');
N = cat(3, nx, ny, nz);

% results the overlaps with selective search boxes
function overlaps = computeOverlaps(selboxes, gtboxes)
selboxes = convertToXYWH(selboxes);
gtboxes = convertToXYWH(gtboxes);
overlaps = boxoverlap(selboxes, gtboxes);

function a = convertToXYWH(a)
a = [a(:, 1) a(:, 2) a(:, 3) - a(:, 1) a(:, 4) - a(:, 2)];

