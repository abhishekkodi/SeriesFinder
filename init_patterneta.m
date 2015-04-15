%opt_initscore_coef
%--Input: t1,t2,h1,h2,ds
mlen=max(pset(t1:t2,2))+1;
score_coef=zeros(mlen^2,13,lenlist);
norm=zeros(mlen^2,13,lenlist);
ind=0;

for n=t1:t2
    len=pset(n,2);
        %----score_coef of the set
        for k1=1:len
            for k2=(k1+1):len
                i1=min(list(k1),list(k2));
                i2=max(list(k1),list(k2));
                score_coef((k1-1)*len+k2,:,ind)=eta(ind,:).*[LocEntry(i1,i2).*HB_LocEntry_index(i1,i2),...
                    MnsEntry(i1,i2).*HB_MnsEntry_index(i1,i2),dayapart(i1,i2).*HB_dayapart_index(i1,i2),...
                    HB_dis(i1,i2),Injure(i1,i2).*HB_Injure_index(i1,i2),premises(i1,i2).*HB_premises_index(i1,i2),...
                    ransacked(i1,i2).*HB_Ransacked_index(i1,i2),residents(i1,i2).*HB_Residents_index(i1,i2),...
                    (~isnan(HB_timeframe(i1,i2)).*HB_timeframe_index(i1,i2)).*HB_timeframe(i1,i2),...
                    dayweek(i1,i2).*HB_week_index(i1,i2),HB_seasonal(i1,i2),(HB_SP_index(i1,i2)==1).*suspect(i1,i2),victim(i1,i2).*HB_VI_index(i1,i2)];
                
                norm((k1-1)*len+k2,:,ind)=eta(ind,:).*[HB_LocEntry_index(i1,i2),HB_MnsEntry_index(i1,i2),HB_dayapart_index(i1,i2),1,...
                    HB_Injure_index(i1,i2),HB_premises_index(i1,i2),HB_Ransacked_index(i1,i2),HB_Residents_index(i1,i2),...
                    (~isnan(HB_timeframe(i1,i2)).*HB_timeframe_index(i1,i2)),HB_week_index(i1,i2),1,(~isnan(HB_SP_index(i1,i2)).*HB_SP_index(i1,i2)),HB_VI_index(i1,i2)];
                score_coef((k2-1)*len+k1,:,ind)=score_coef((k1-1)*len+k2,:,ind);
                norm((k2-1)*len+k1,:,ind)=norm((k1-1)*len+k2,:,ind);
            end
        end
    end
end