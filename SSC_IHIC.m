function  [F,S,W]=SSC_IHIC(X,Y,Y_L,n,V,k,C,d,r,lambda,labeled_N)
% X:sample n*d_v,d_v denotes v-th view dimension
% Y:sample label
% Ratio:percent of training data sets
% K:number of neighbors
% Lamda:regular parameter

 NITER=30;
%% innitialization
 %initialize distX
 S0 = zeros(n);
 rr = zeros(n,1);
 for v=1:V
 distX(:,:,v)=  L2_distance_1( X{v}',X{v}' ) ; 
 S0 = S0+distX(:,:,v);
 end
 distX=S0/V;
 [distXs, idx] = sort(distX,2);
 % initialize S
    S=zeros(n);
    for i = 1:n
    di = distXs(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    S(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);              
    end;
% 
% % initialize F
S = (S+S')/2;                                                        
D = diag(sum(S));
L = D - S;

%initialize W
  for v=1:V
  W{v}=zeros(d(v));
  A{v}=X{v}'*L*X{v};

 temp1 = 0;
 for i = 1:d(v)
 temp1 = temp1 + 1/(A{v}(i,i));
 end
 
 for i = 1 : d(v)
 W{v}(i,i) = 1/(A{v}(i,i)* temp1); 
 end
 end
%compute alpha and lambda
 r=mean(rr);
%  if r<=0
%  end
thresh=10^-8; 
%% =====================  updating =====================

for iter = 1:NITER
       
    %update W
    for v=1:V
    T{v} = X{v}'*L*X{v};
    temp1 = 0;
    for i = 1:d(v)
    temp1 = temp1 + 1/(T{v}(i,i));
    end
    for i = 1:d(v)
    W{v}(i,i) = 1/(T{v}(i,i)* temp1); 
    end 
    end 
    
    %update F
    L_uu = L((labeled_N+1):end, (labeled_N+1):end);
    L_ul = L((labeled_N+1):end, 1:labeled_N);
    F_u = (-1)*pinv(L_uu)*L_ul*Y_L;
    F=[Y_L;F_u];
   
    %update S
    distf = L2_distance_1(F',F');
    distxx=0;
    for v=1:V
    distx(:,:,v) = L2_distance_1(W{v}*X{v}',W{v}*X{v}');
    distxx=distxx+distx(:,:,v);
    end
    S = zeros(n);
    for i=1:n  
    idxa0=idx(i,2:k+1);
    dfi = distf(i,idxa0);
    dxi = distxx(i,idxa0);
    ad = -(dxi+lambda*dfi)/(2*r);
    S(i,idxa0) = EProjSimplex_new(ad);
    end;
    SS = (S+S')/2;   
    D = diag(sum(SS));
    L = D-SS;
  % objection function value
    ST=0;
    for v=1:V
    Tra{v}=trace(W{v}*X{v}'*L*X{v}*W{v});
    ST=ST+Tra{v};
    end
   Obj(iter) = 2*ST + r*(norm(S,'fro'))^2 + 2*lambda*trace(F'*L*F);
        if iter>2
        Obj_diff = ( Obj(iter-1)-Obj(iter) )/Obj(iter-1);
        if Obj_diff < thresh
            break;
        end
    end
end



 
