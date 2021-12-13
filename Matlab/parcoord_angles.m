%% Ordering of the criteria based on the SRD angle method. Written by János Abonyi and Ádám Ipkovich, 10.10.2021 (ddmmyyyy)
%parcoord_angles - returns the placement order of the variables based on
%the srd_angle function. The algorithm takes two references, namely the
%golden standard and the closest variable as starting references. The next
%variable is selected and the angles between the references and the
%variable are calculated. The variable place next to the reference whose
%angle is lower than the other.
%[angles, axes, index] = parcoord_angles(srdmatrix, srdi) returns the
%angles 'angles' and the 'axes' srd values in 'index' order.

function [angles, axes, index] = parcoord_angles(srdmatrix, srdi)

[N,n] = size(srdmatrix);

angles = [];
leftax = 1;
rightax = [2];
rgh = [];
lft = [];
axes = [srdi(1), srdi(2)];
index = [1, 2];
for i=3:n
   
    %Calculation of angle to left-hand side and right-hand side neighbour
    if(srdmatrix(1, i) - srdmatrix(1, rightax) <= srdmatrix(i,rightax))
%        rgh = ((srdmatrix(1, i)^2 + srdmatrix(1, rightax)^2) - srdmatrix(i,rightax)^2)/(2*srdmatrix(1,rightax)*srdmatrix(1, i));
%        rgh = acosd(rgh);
         rgh = srd_angle(srdmatrix, i, rightax);
    else
        rgh = 0;
    end
    if(srdmatrix(1, i) - srdmatrix(1, leftax) <= srdmatrix(i,leftax))
         lft = srd_angle(srdmatrix, i, leftax)
%        lft =((srdmatrix(1, i)^2 + srdmatrix(1, leftax)^2) - srdmatrix(i,leftax)^2)/(2*srdmatrix(1,leftax)*srdmatrix(1, i));
%        lft = acosd(lft);
    else
       lft = 0;
    end
    
    % Selection of smaller angle.
    if( rgh <= lft)
    angles = [angles, rgh];
    axes = [axes, srdi(i)];
    rightax = i;  
    index = [index, i]
    else
    angles = [angles, lft];
    axes = [-srdi(i), axes];
    leftax = i;
    index = [i, index]
    end
end

end