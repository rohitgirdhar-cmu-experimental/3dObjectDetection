function convertNormalDataToTxt()
datadir = '/nfs/ladoga_no_backups/users/dfouhey/NYUData/normals';
outdir = '/home/rgirdhar/Work/Projects/002_GeoObjDet/dataset/NYU/NormalsData';
try
  matlabpool open 8;
catch
end

parfor i = 1 : 1449
  i
  fpath = fullfile(datadir, sprintf('nm_%06d.mat', i));
  [nx, ny, nz] = getN(fpath);
  outfpath = fullfile(outdir, sprintf('%d.txt', i));
  fid = fopen(outfpath, 'w');
  for r = 1 : size(nx, 1)
    for c = 1 : size(nx, 2)
      fprintf(fid, '%f,%f,%f ', nx(r, c), ny(r, c), nz(r, c));
    end
    fprintf(fid, '\n');
  end
  fclose(fid);
end

function [nx,ny,nz] = getN(fpath)
load(fpath, 'nx', 'ny', 'nz');

