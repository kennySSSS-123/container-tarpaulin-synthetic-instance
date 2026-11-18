function t = generateTest(d, N)
%GENERATETEST  Held-out demand batches used in the allocation experiments.
%   t = GENERATETEST(d, N) returns N seven-day scenarios drawn around the
%   baseline demand of instance d. The generator is reproduced verbatim from
%   the experiment code of the paper; the multipliers are those documented in
%   Section 4.2:
%       common factor        U(0.85, 1.15)
%       station factor       U(0.90, 1.10)
%       daily factor         U(0.95, 1.05)
%       tarpaulin intensity  U(0.20, 0.65) per TEU
%       tarpaulin weather    U(1.00, 1.10)
%   Tarpaulin demand is rounded upward; container demand is rounded.
%   Seeds used in the paper: 20261012 ... 20261017 with N = 32.
%
%   Required fields of d: nJ, nS, prob (nS-by-1), demand20 and demand40
%   (nJ-by-nS, seven-day totals per scenario).
%
%   See also MAKESCENARIOBATCH.

t=d;t.nS=N;t.prob=ones(N,1)/N;t.capFactor=ones(N,1);t.demand20=zeros(d.nJ,N);t.demand40=t.demand20;t.tarpDemand=t.demand20;
mu20=d.demand20*d.prob/7;mu40=d.demand40*d.prob/7;
for s=1:N
 common=.85+.30*rand; intensity=.20+.45*rand;
 for j=1:d.nJ
  station=.90+.20*rand;weather=1+.10*rand;
  for day=1:7
   a=round(mu20(j)*common*station*(.95+.10*rand));b=round(mu40(j)*common*station*(.95+.10*rand));
   t.demand20(j,s)=t.demand20(j,s)+a;t.demand40(j,s)=t.demand40(j,s)+b;
   t.tarpDemand(j,s)=t.tarpDemand(j,s)+ceil((a+2*b)*intensity*weather);
  end
 end
end
t=refresh(t);
end

function d=refresh(d)
d.demandTEU=d.demand20+2*d.demand40;d.scenarioDemandTEUTotal=sum(d.demandTEU,1)';d.scenarioTarpTotal=sum(d.tarpDemand,1)';d.scenarioIDs="T"+string((1:d.nS)');d.scenarioNames=d.scenarioIDs;
end
