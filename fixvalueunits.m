function [str] = fixvalueunits(somedist, strunits)
%
prfxs = {'T', 'G', 'M', 'k', '', 'm', '\mu', 'n', 'p'};
sizeunit = [1e12 1e9 1e6 1e3 1 1e-3 1e-6 1e-9 1e-12];

a = somedist./sizeunit';
idx = intersect(find(a>0.1), find(a<10));

str = sprintf('%3.4g [%s%s]', a(idx), prfxs{idx}, strunits);