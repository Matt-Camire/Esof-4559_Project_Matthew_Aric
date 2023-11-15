% DataReorganization.m
% This code will convert the annotation data -
% which is currently a structure object - into
% a series of tables. This should allow for easier
% data manipulation and processing.

%Load training data
Anno=load('AnnoTrain.mat');
Anno=Anno.AnnoTrain;

%Reconfigure structure to be more useable
AnnoAct=struct2table(Anno.act);
rows=1:size(AnnoAct,1);
AnnoAct.img_id=rows.';

%Add merge single_person and act to make one table
AnnoSingle=cell2table(Anno.single_person,"VariableNames",{'single_person'});
AnnoSingle.img_id=rows.';
AnnoTable=join(AnnoAct,AnnoSingle);

%Add image substructure to table
AnnoImage=struct2table(struct2table(Anno.annolist).image);
AnnoImage.img_id=rows.';
AnnoTable=join(AnnoTable,AnnoImage);

%Add annorect substructure to table
AnnoRect=cell2table(struct2table(Anno.annolist).annorect,"VariableNames",{'annorect'});
AnnoRect.img_id=rows.';
%AnnoTable=join(AnnoTable,AnnoRect);

%Rearrange columns
AnnoTable=[AnnoTable(:,2) AnnoTable(:,1) AnnoTable(:,3:end)];

%Extract annorect and expand annotable
A=AnnoRect(1,1).annorect{1}; %Extract (i)
A=struct2table(A); %Expand annorect into table
s=size(A); s=s(1); %Get size
B=1.*ones(s,1); %Create vector for id number (i)
B=array2table(B);
B.Properties.VariableNames="img_id"; %Change column name
A=[A B]; %Add id vector to table
AnnoRect2=A; %Start new table

%Append all expanded annorect substructures to the new table
for i=2:height(AnnoRect)
    if ~isempty(AnnoRect(i,1).annorect{1}) %Ensure substructure is not empty
    A=AnnoRect(i,1).annorect{1}; %Extract (i)
    A=struct2table(A); %Expand annorect into table
    s=size(A); h=s(1); w=s(2); %Get sizes
    if w==7 %Ensure annorect has matching columns
    empty=false;
    for j=1:h %Remove empty substructures again
        if isa(A(j,5).annopoints,'cell')
            empty=true;
        end
    end
    if empty %If there are empties remove from AnnoTable too
    AnnoTable(AnnoTable.img_id==i,:)=[];
    else %If there are no empties in the substructure
    B=i.*ones(h,1); %Create vector for id number (i)
    B=array2table(B); %Convert vector to table for appending
    B.Properties.VariableNames="img_id"; %Change column name
    A=[A B]; %Append id vector to temporary table
    AnnoRect2=[AnnoRect2;A]; %Append rows to table
    end
    end
    end
end

rows=1:size(AnnoRect2,1);
AnnoRect2.annorect_id=rows.'; %Add annorect_id column

AnnoTable=AnnoTable(:,[1,2,4]); %Remove annorect substructure from table
%Remove single_person since we won't need it

%Save tables so the code won't have to run again
save('AnnoTable.mat',"AnnoTable")
save('AnnoRect.mat',"AnnoRect2")