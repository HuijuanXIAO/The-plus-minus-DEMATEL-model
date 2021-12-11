%% Plus-minus DEMATEL Model
%% Step 1: Generating the direct-relation matrix (Z).
%The data have been included in the code to ensure working without external file
%The code can be applied to other cases by only changing the matrix Z.
clear
Z=[0,0,6,5,8,2,1,1,0,5,1,0,-2,1,-5,1;5,0,-1,2,9,-3,1,3,-3,2,1,0,3,0,2,0;0,1,0,0,2,0,3,3,0,2,0,1,0,1,-1,2;3,1,4,0,6,8,2,7,3,3,3,4,1,5,8,10;4,3,4,7,0,4,1,4,0,2,2,0,0,0,0,3;1,4,5,3,0,0,1,3,0,1,6,6,1,2,4,1;2,2,2,5,1,1,0,4,4,2,4,3,5,-3,-2,2;4,2,2,7,4,3,1,0,4,4,3,2,-1,-2,0,2;2,5,-1,0,0,1,5,1,0,1,7,5,4,-2,-5,-3;6,4,6,4,8,4,2,6,1,0,1,0,1,1,0,2;2,-1,6,1,1,3,1,1,2,1,0,1,1,-1,-2,2;0,1,1,1,0,7,4,3,2,0,2,0,2,2,5,0;2,2,5,7,7,7,2,7,7,1,7,11,0,7,7,0;2,3,1,0,0,5,3,3,2,1,1,7,5,0,2,0;-1,1,1,-2,0,3,-1,-1,-2,0,-1,1,2,0,0,0;5,4,4,3,7,6,4,4,3,3,4,2,2,6,1,0]
[nrows,ncols]=size(Z);
%% Step 2: Normalizing the direct-relation matrix (X)
for c=1:ncols
    for r=1:nrows
        if Z(r,c)<0
            Z_pos(r,c)=0
        else
            Z_pos(r,c)=Z(r,c)
        end
    end
end

Col_pos_sum=sum(Z);
Row_pos_sum=sum(Z,2);
for c=1:ncols
    for r=1:nrows
        if Z(r,c)>0
            Z_neg(r,c)=0
        else
            Z_pos(r,c)=Z(r,c)  
        end
    end
end
Col_neg_sum=sum(Z);
Row_neg_sum=sum(Z,2);
Mat_sum=[Col_pos_sum';Row_pos_sum;-Col_neg_sum';-Row_neg_sum];
Max=max(Mat_sum);
X=Z/Max;
%% Step 3: Calculating the total-relation matrix (T) and indirect-relation matrix (IX)
T=X*(eye(nrows)-X)^-1;
IX=T-X
%% Step 4: Obtaining the total synergy effects (SE), total trade-off effects(TE), total effects of as a deliver(TD) and total effects as a receiver(TR)
for c=1:ncols
    for r=1:nrows
        if T(r,c)<0
            T_pos(r,c)=0
        else
            T_pos(r,c)=T(r,c)
        end
    end
end
for c=1:ncols
    for r=1:nrows
        if T(r,c)>0
            T_neg(r,c)=0
        else
            T_neg(r,c)=T(r,c)
        end
    end
end
D_pos=sum(T_pos,2);
D_neg=sum(T_neg,2);
R_pos=sum(T_pos);
R_neg=sum(T_neg);
SE=D_pos+R_pos';
TE=D_neg+R_neg';
TD=D_pos-D_neg;
TR=R_pos-R_neg;
TD_plus_TR=TD+TR';
TD_minus_TR=TD-TR';
%% Step 5: Generating the interactive weight
Ne=D_pos+D_neg+R_pos'+R_neg';
Nor_Ne=0.1+0.9*((Ne-min(Ne))/(max(Ne)-min(Ne)));
Weight=Nor_Ne/sum(Nor_Ne);
