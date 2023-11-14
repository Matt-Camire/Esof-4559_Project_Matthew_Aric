Anno=load('AnnoTrain.mat');
Anno=Anno.AnnoTrain;
ActionTable=load('ActionTable.mat');
ActionTable=ActionTable.ActionTable;

active=false;
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