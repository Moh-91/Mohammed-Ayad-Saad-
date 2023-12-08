function i=RouletteWheelSelectionMin(P)

    
%     [P id]=sort(P);
% P=1./P;
% r=rand;
% i=1;
% while r>0
%     r=r-P(i);
%     i=i+1;
% end
% i=id(i-1);
    r=rand;
    P=1-P;
%     [P id]=sort(P);
%    P=(P-min(P))./((max(P)-min(P)));
    C=cumsum(P);
     C=(C-min(C))./((max(C)-min(C)));
    i=find(r<=C,1,'first');
%     i=id(in);
    

end