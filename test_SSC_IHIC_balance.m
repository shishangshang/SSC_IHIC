function [ACC]=test_SSC_IHIC_balance(X,Y,Ratio,k,lambda)
V=length(X);
for v=1:V 
[n,d(v)]=size(X{v});
end
C=max(Y);
r=-1;  
% departing into training and testing
each_class_num=zeros(1,C);
thresh = 10^-8;

part=floor(Ratio*n/C);
labeled_N=part*C;

list = zeros(1,labeled_N);
for c=1:C
list(1,(c-1)*part+1:c*part) = sort(randperm(floor(n/C),part)+floor((c-1)*n/C)); 
end
List=list;
List_ = setdiff(1:1:n,List); % the No. of unlabeled data

for v=1:V
    XP{v}=[X{v}(List,:);X{v}(List_,:)];
    X_train{v}=X{v}(List,:);
    X_test{v}=X{v}(List_,:);
end
 YP=[Y(list,:);Y(List_,:)];
 Y_l=Y(list,:);
 Y_u=Y(List_,:);
 Y_L=zeros(length(Y_l),C);
 for l=1:length(Y_l)
     Y_L(l,Y_l(l))=1;
 end
 X=XP;
 Y=YP;
 [F,S,W]=SSC_IHIC(X,Y,Y_L,n,V,k,C,d,r,lambda,labeled_N);
 %% =====================  result =====================
[~,index1]=max(F((part*C+1):n,:),[],2);
index2=Y((part*C+1):n,:);
ACC = mean(index1 ==index2);