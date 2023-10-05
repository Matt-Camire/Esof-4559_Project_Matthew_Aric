Anno=load('mpii_human_pose_v1_u12_1.mat'); %Import RELEASE structure
Anno=Anno.RELEASE;

%We don't need any video data so we will remove it.
Anno=rmfield(Anno,'video_list'); %Remove video link list
Anno=rmfield(Anno,'version'); %Remove version number
Anno.annolist=rmfield(Anno.annolist,'frame_sec'); %Remove video frame data
Anno.annolist=rmfield(Anno.annolist,'vididx'); %Remove video id data

%There are redundancies in the Anno.act structure. We will create a new
%table to eliminate this issue.
ActionTable=struct2table(Anno.act); %Convert act structure to table
ActionTable=unique(ActionTable); %Extract only unique actions
ActionTable=sortrows(ActionTable,'act_id'); %Sort by the act_id
%Remove the cat_name and act_name fields to eliminate renundancies.
%Each action is now stored in ActionTable.
Anno.act=rmfield(Anno.act,"cat_name");
Anno.act=rmfield(Anno.act,"act_name");

save('ActionTable.mat',"ActionTable")
save('AnnoClean.mat',"Anno")