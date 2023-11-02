Anno=load('AnnoTrain.mat');
Anno=Anno.AnnoTrain;
ActionTable=load('ActionTable.mat');
ActionTable=ActionTable.ActionTable;

active=true;
%Graph of category distribution
if active
ActionList=struct2table(Anno.act);
%Join action table and list on matching act_id and isolate cat_name
catList=join(ActionList,ActionTable).cat_name;
%Find unique category names
categories=string(unique(catList));
%Count the occurences of the first category
count=sum(ismember(catList,categories{1}));
%Add other categories to a count array
for i=2:length(categories)
    count=cat(1,count,sum(ismember(catList,categories{i})));
end
%Plot counts for categories
categoryPlot=bar(categorical(categories),count);
title('Distribution of Action Categories')
xlabel('Categories')
ylabel('Count')
saveas(categoryPlot,'categoryPlot.jpg'); %export
end

%Reconfigure structure to be more useable
AnnoAct=struct2table(Anno.act);
rows=1:size(AnnoAct,1);
AnnoAct.id=rows.';

AnnoSingle=cell2table(Anno.single_person,"VariableNames",{'single_person'});
AnnoSingle.id=rows.';
AnnoTable=join(AnnoAct,AnnoSingle);

AnnoImage=struct2table(struct2table(Anno.annolist).image);
AnnoImage.id=rows.';
AnnoTable=join(AnnoTable,AnnoImage);

AnnoRect=cell2table(struct2table(Anno.annolist).annorect,"VariableNames",{'annorect'});
AnnoRect.id=rows.';
AnnoTable=join(AnnoTable,AnnoRect);

AnnoTable=[AnnoTable(:,2) AnnoTable(:,1) AnnoTable(:,3:end)];

%Create scatterplots of joint locations for one image
%Variable names will be fixed in the future
one=struct2table(Anno.annolist).annorect;
two=struct2table(one{1}).annopoints;
three=struct2cell(two);
four=struct2table(three{1});
dots1=figure;
scatter(four.x,720-four.y,'filled','g');
axis equal;
xlim([0 1280]);
ylim([0 720]);
dots2=figure;
four=struct2table(three{2});
scatter(four.x,720-four.y,'filled','g');
axis equal;
xlim([0 1280]);
ylim([0 720]);

saveas(dots1,'dots1.png'); %export
saveas(dots2,'dots2.png'); %export






%{
%Heatmap of joint positions
Annolist=Anno.annolist;
Annolist=struct2table(Annolist);

%Extract nulls
nulls=isempty(Annolist(1,:).annorect{1});
for i=2:length(Annolist.annorect)
    nulls=cat(1,nulls,isempty(Annolist(i,:).annorect{1}));
end
Annolist(nulls,:)=[];
Annolist=Annolist.annorect;


a=struct2table(Annolist{1});
width=size(a,2);

%}

%{
b=struct2table(Annolist{1507});
c=b(1,:).annopoints;
isempty(c{1})
b=struct2table(Annolist{1507});
d=b(2,:).annopoints;
isempty(d{1})
%}

%{
for i=2:length(Annolist)
    if width==size(struct2table(Annolist{i}),2)
        for j=1:size(struct2table(Annolist{i}),1)
            b=struct2table(Annolist{i});
            c=struct2cell(b(j,:).annopoints);
            if ~isempty(c{1})
                a=cat(1,a,b(j,:));
            end
        end
    end
end
%}


%Fail on i=1507
%{
for i=2:length(Annolist)
    if width==size(struct2table(Annolist{i}),2)
        a=cat(1,a,struct2table(Annolist{i}));
    end
end
%}

%Example for graphing string array
%Used as skeleton to plot category distribution
%{
clear b;
test={'one','two','three','one','one'};
a=string(unique(test));
b=sum(ismember(test,a{1}));
for i=2:length(a)
    b=cat(1,b,sum(ismember(test,a{i})));
end
bar(categorical(a),b);
%}