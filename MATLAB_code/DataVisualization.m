clear Anno;
Anno=load('AnnoTrain.mat');
Anno=Anno.AnnoTrain;

TestSet=cell2mat(struct2cell(Anno.act))>0;

%histogram(cell2mat(struct2cell(Anno.act)));
Anno.act=Anno.act(~TestSet);