folder_to_search = pwd;
filetype = fullfile(folder_to_search, '*.png');
%folder_to_output = '..\\';
folder_to_output = pwd;
sub_folder = 'CB_Test';
l = 6; % Hilbert Curve order
v = 1; % Hilbert Curve orientation
filelist = dir(filetype);
ST = [];
for Readinfile = 1 : length(filelist)
  File2Read = fullfile(folder_to_search, filelist(Readinfile).name);
  img_tmp = imread(File2Read);
  figure();
  imshow(img_tmp);
  ST_tmp = SpatialTraverse(img_tmp, l, v);
  ST = vertcat(ST,ST_tmp);
%   figure();
%   plot3(ST(:,1),ST(:,2),ST(:,3));title('Trajectory of Traversed Spaptial Data');hold on;
end
[Idx, Ub, Lb] = HAS(ST, size(ST,1)/4);
S = SymbG(ST, Ub, Lb);
figure();
scatter3(ST(:,1),ST(:,2),ST(:,3),5,S,'filled');title('Trajectory of Traversed Spaptial Data');hold on;
PlotCell(Ub, Lb);
view(55,25);
for Readinfile = 1 : length(filelist)
  File2Read = fullfile(folder_to_search, filelist(Readinfile).name);
  img_tmp = imread(File2Read); 
  ST_tmp = SpatialTraverse(img_tmp, l, v);
  [s, ~] = SymbG(ST_tmp, Ub, Lb);
  IFS(s, size(Ub,1), 0.045 ,1);
  [IdxM, HRR, HMean, HVar, HSkew, HKurt, HEnt, HGini] = RHRQA(s, size(Ub,1),1);
  Tmp_HRQA = horzcat(IdxM, HRR, HMean, HVar, HSkew, HKurt, HEnt, HGini);
  filename = filelist(Readinfile).name;filename = filename(1:end-4);
  File2Write = fullfile(folder_to_output, strcat(filename,'.csv'));
  csvwrite(File2Write,Tmp_HRQA);
end