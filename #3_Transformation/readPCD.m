% *********************************************
% Point Cloud Data preprocessing #1 Visualization
% Jongwon Kim
% Deep.I Inc
% deepi.contac.us@gmail.com
% https://deep-eye.tistory.com
% *********************************************

%%
addpath(genpath('../#0_Sample'))
addpath(genpath('../#0_Function'))
addpath(genpath('../#1_Visualization'))
addpath(genpath('../#2_Segmentation'))
% load pcd file
lidar_dir = fopen('1.bin');
lidar_file = fread(lidar_dir,[4 inf],'single')';
fclose(lidar_dir);

% X, Y, Z, INTENSITY
% 1st preprocessing
xyzi = round(lidar_file,2); 

% 2nd preprocessing
xyzi = ROIextraction(xyzi,[-30,30],[-30,30],[-2,5],'height'); 

% 3rd preprocessing
aidx = segmentation(xyzi,60);

% 4th preprocessing
new_xyzi = transformation(xyzi, 60);

subplot(1,2,2)
scatter3(new_xyzi(:,1),new_xyzi(:,2),new_xyzi(:,3),'.k');
axis([-20 20 -20 20 -30 +30])
subplot(1,2,1)
scatter3(xyzi(:,1),xyzi(:,2),xyzi(:,3),'.k');
axis([-30 30 -30 30 -5 +10])

%% drone dataset
dronedata = load('drone.mat');
pcd = dronedata.pcd;
for i = 1 : 20
    xyz = pcd{i};
    scatter3(xyz(:,1),xyz(:,2),xyz(:,3),'.r')
    pause(0.5)
end

xyzi = round(xyz,2); 
xyzi = ROIextraction(xyz,[-30,30],[-30,30],[-50,5],'height'); 
new_xyzi = transformation(xyzi, 30);
scatter3(new_xyzi(:,1),new_xyzi(:,2),new_xyzi(:,3),'.k');

