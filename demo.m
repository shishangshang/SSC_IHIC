clc
clear all
close all
%% 载入数据
 load('MSRC-v1')
% load('HW')
%% 排序
z=0;
  C=max(Y);
  V=length(X);
  [N,~]=size(X{1});
  for i=1:C
    for j=1:N
        if Y(j,:)==i;
           z=z+1;
           for v=1:V
             XX{v}(z,:)=X{v}(j,:);
           end
             YY(z,:)=Y(j,:);
        end
    end
  end
  X=XX;
  Y=YY;
 %% 预处理
  for i = 1 :V
    for  j = 1:N
           X{i}(j,:) = ( X{i}(j,:) - mean( X{i}(j,:) ) ) / std( X{i}(j,:) ) ;
    end
  end
%% 模型建立与测试
    s=0;
    Ratio=0.1;
    for i=-3:3
    s=s+1;
   [ACC(s,:)]=test_SSC_IHIC_balance(X,Y,Ratio,5,10^(i));
%    [ACC(s,:)]=test_SSC_IHIC_unbalance(X,Y,Ratio,5,10^(i));
    end