function [NImg] = unquantizeNormals(NIdx, vocab)
matSize = 20;
N = convertTo8KRep(NIdx);
NImg = assignToNormals(N, vocab.vocabs{1}.normals);
NImg = reshape(NImg, [matSize, matSize, 3]);

function [res] = convertTo8KRep(NIdx)
wid = 20;
N = reshape(NIdx, 1, []);
res = zeros(1, length(N) * wid);
for i = 1 : numel(N)
  res((i - 1) * wid + N(i)) = 1;
end

