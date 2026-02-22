function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 193363;
% L1 = 6;
% L2 = 3;
% z8 = mod(L1,7)+1;
% d8 = mod(L2,7)+1;
d = 0.85;
Edges = [ 1 1 2 2 2 3 3 3 4 4 4 5 5 6 6 7 8;
          4 6 3 4 5 5 6 7 5 6 8 4 6 4 7 6 7];
I = speye(8);
B = sparse(Edges(2,:),Edges(1,:),1,8,8);
TMP = sum(B,1)';
TMP = 1./TMP;
A = spdiags(TMP,0,8,8);
b = ones(8,1);
b = b*(1-d)/8;
r = sparse(I-d.*B*A)\b;
end