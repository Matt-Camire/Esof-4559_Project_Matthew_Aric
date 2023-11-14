% DataReorganization2.m
% This code will reorganize the AnnoRect table into more subtables.

Anno=load('AnnoRect.mat');
Anno=Anno.AnnoRect2;

%Extract objpos subtable
%Extract annopoints subtable
%Remove objpos and annopoints columns from Anno

A=struct2table(Anno(1,7).objpos);
B=array2table(1.*ones(1,1));
B.Properties.VariableNames="annorect_id";
B=[A B];
AnnoPos=B;

for i=2:height(Anno)
    A=struct2table(Anno(i,7).objpos);
    B=array2table(i.*ones(1,1));
    B.Properties.VariableNames="annorect_id";
    B=[A B];
    AnnoPos=[AnnoPos;B];
end

A=struct2table(Anno(1,5).annopoints.point);
B=array2table(1.*ones(height(A),1));
B.Properties.VariableNames="annorect_id";
B=[A B];
AnnoPoint=B;

for i=2:height(Anno)
    A=struct2table(Anno(i,5).annopoints.point);
    B=array2table(i.*ones(height(A),1));
    B.Properties.VariableNames="annorect_id";
    B=[A B];
    if ~ismember("is_visible",B.Properties.VariableNames)
        B.is_visible=zeros(height(B),1);
    end
    if isa(B.is_visible,'logical')
        B.is_visible=table2cell(array2table(B.is_visible));
    end
    AnnoPoint=[AnnoPoint;B];
end

rows=1:height(AnnoPoint);
AnnoPoint.point_id=rows.';

Anno=Anno(:,[1:4,6,8:end]);

AnnoPos.Properties.VariableNames=["xbox","ybox","annorect_id"];

save('AnnoRect2.mat',"Anno")
save('AnnoPos.mat',"AnnoPos")
save('AnnoPoint',"AnnoPoint")