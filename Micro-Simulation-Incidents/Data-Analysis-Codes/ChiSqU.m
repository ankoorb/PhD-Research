x = a;
n = length(x);
edges = linspace(0,1,4);
expectedCounts = n * diff(edges);
[h,p,st] = chi2gof(x,'edges',edges,'expected',expectedCounts)