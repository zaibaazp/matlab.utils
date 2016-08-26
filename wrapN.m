function [idx] = wrapN(x,N)
%  WRAP AROUND AN INDEX.
% Go i+1 or i-1 without worriyng about the damn indexes.
%

idx = (1 + mod(x-1, N));