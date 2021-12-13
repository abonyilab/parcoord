%srd_angle - Calculates the angles between two srd value, where srdmatrix 
% is a matrix where each column represents a variable as a reference. The First is the golden
%function angle = srd_angle(srdmatrix, j, m) returns teh deviation degree
%of the golden, and the two other variable in degree. 
%j and m are indexes

function angle = srd_angle(srdmatrix, j, m)

 angle = ((srdmatrix(1, j)^2 + srdmatrix(1, m)^2) - srdmatrix(j,m)^2)/(2*srdmatrix(1,j)*srdmatrix(1,m));
 angle = acosd(angle);
 
end