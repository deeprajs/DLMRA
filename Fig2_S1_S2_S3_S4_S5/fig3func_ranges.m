function [minparams,sum0,sum1,sum2,sum5] = fig3func_ranges(actual_param,predicted_param,SSE,count,bot,top)

for i=1:count
    paramtheor(i,:)=actual_param{1,i};
    [M,I] = min(SSE{1,i}(1:10));
    parampred0(i,:)=predicted_param{1,i}(I,:);
    [~,I] = min(SSE{2,i});
    parampred1(i,:)=predicted_param{2,i}(I,:);
    [M,I] = min(SSE{3,i});
    parampred2(i,:)=predicted_param{3,i}(I,:);
    [M,I] = min(SSE{4,i});
    parampred5(i,:)=predicted_param{4,i}(I,:);
end
    minparams.paramtheor=paramtheor;
    minparams.parampred0=parampred0;
    minparams.parampred1=parampred1;
    minparams.parampred2=parampred2;
    minparams.parampred5=parampred5;


%no noise
p=reshape(parampred0,length(parampred0(:)),1);
t=reshape(paramtheor,length(paramtheor(:)),1);
ta=find(t>bot&t<top);
tar0=sum(p(ta)>0)/sum(t>bot&t<top);
tr=find(t<(-1*bot)&t>(-1*top));
trr0=sum(p(tr)<0)/sum(t<(-1*bot)&t>(-1*top));
sum0=(tar0+trr0)/2;

%1:10 noise
p=reshape(parampred1,length(parampred1(:)),1);
t=reshape(paramtheor,length(paramtheor(:)),1);
ta=find(t>bot&t<top);
tar1=sum(p(ta)>0)/sum(t>bot&t<top);
tr=find(t<(-1*bot)&t>(-1*top));
trr1=sum(p(tr)<0)/sum(t<(-1*bot)&t>(-1*top));
sum1=(tar1+trr1)/2;

%1:5 noise
p=reshape(parampred2,length(parampred2(:)),1);
t=reshape(paramtheor,length(paramtheor(:)),1);
ta=find(t>bot&t<top);
tar2=sum(p(ta)>0)/sum(t>bot&t<top);
tr=find(t<(-1*bot)&t>(-1*top));
trr2=sum(p(tr)<0)/sum(t<(-1*bot)&t>(-1*top));
sum2=(tar2+trr2)/2;

%1:2 noise
p=reshape(parampred5,length(parampred5(:)),1);
t=reshape(paramtheor,length(paramtheor(:)),1);
ta=find(t>bot&t<top);
tar5=sum(p(ta)>0)/sum(t>bot&t<top);
tr=find(t<(-1*bot)&t>(-1*top));
trr5=sum(p(tr)<0)/sum(t<(-1*bot)&t>(-1*top));
sum5=(tar5+trr5)/2;
end

