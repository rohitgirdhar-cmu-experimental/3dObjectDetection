function [idx] = quantizeNormals(NImg, vocab)
matSize = 20;
reIm = imresize(NImg, [matSize, matSize]);
[idx, qloss] = assignToCodebook(reIm, vocab.vocabs{1}.normals);

