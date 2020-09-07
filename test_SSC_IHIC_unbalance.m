function [ACC]=test_SSC_IHIC_unbalance(X,Y,Ratio,k,lambda)
V=length(X);
for v=1:V 
[n,d(v)]=size(X{v});
end
C=max(Y);
r=-1;  

%% 训练集与测试集分离
   labeled_N=floor(Ratio*n);
   List = randperm(n,labeled_N);
   List_ = setdiff(1:1:n,List); % the No. of unlabeled data
for v=1:V
    X_train{v}=X{v}(List,:);
    X_test{v}=X{v}(List_,:);
    XP{v}=[X{v}(List,:);X{v}(List_,:)];
end
 YP=[Y(List,:);Y(List_,:)];
 Y_l=Y(List,:);
 Y_u=Y(List_,:);
 Y_L=zeros(length(Y_l),C);
 for l=1:length(Y_l)
     Y_L(l,Y_l(l))=Y_l(l);
 end
 X=XP;
 Y=YP;
 [F,W]=SSC_IHIC(X,Y,Y_L,n,V,k,C,d,r,lambda,labeled_N);
 %% =====================  result =====================

[~,index1]=max(F((labeled_N+1):n,:),[],2);
index2=Y((labeled_N+1):n,:);
ACC = mean(index1 ==index2);