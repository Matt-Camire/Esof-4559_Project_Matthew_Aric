% DataConversion.m

AnnoRect=load('AnnoRect2.mat');
AnnoRect=AnnoRect.Anno;
AnnoPos=load('AnnoPos.mat');
AnnoPos=AnnoPos.AnnoPos;
AnnoPoint=load('AnnoPoint.mat');
AnnoPoint=AnnoPoint.AnnoPoint;
AnnoTable=load('AnnoTable.mat');
AnnoTable=AnnoTable.AnnoTable;
ActionTable=load('ActionTable.mat');
ActionTable=ActionTable.ActionTable;

writetable(AnnoRect,'AnnoRect.csv');
writetable(AnnoPos,'AnnoPos.csv');
writetable(AnnoPoint,'AnnoPoint.csv');
writetable(AnnoTable,'AnnoTable.csv');
writetable(ActionTable,'ActionTable.csv');