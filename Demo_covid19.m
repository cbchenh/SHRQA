folder_to_search = 'C:\Users\CHENG-BANG\Dropbox\matlab\SFC\SHRQA\CB_Test\all';
filetype = fullfile(folder_to_search,'*.png');
%folder_to_output = '..\\';
folder_to_output = 'C:\Users\CHENG-BANG\Dropbox\matlab\SFC\SHRQA\CB_Test\all';

l = 8; % Hilbert Curve order
v = 1; % Hilbert Curve orientation
filelist = dir(filetype);
ST = [];
for Readinfile = 1 : length(filelist)
  File2Read = fullfile(folder_to_search, filelist(Readinfile).name);

  img_tmp = imread(File2Read);
  !figure();
  !imshow(img_tmp);
  !img_tmp = rgb2gray(img_tmp);
  [a,b,c]=size(img_tmp);
  if c == 3
    sub_img = rgb2gray(img_tmp(405:660,149:404,:));
  else
    sub_img = img_tmp(405:660,149:404);
  end
  figure();
  imshow(sub_img);
  ST_tmp = SpatialTraverse(sub_img, l, v);
  ST = vertcat(ST,ST_tmp);
  !figure();
  !plot3(ST(:,1),ST(:,2),ST(:,3));title('Trajectory of Traversed Spaptial Data');hold on;
end
[Idx, Ub, Lb] = HAS(ST, size(ST,1)/16);
!PlotCell(Ub, Lb);
for Readinfile = 1 : length(filelist)
  File2Read = fullfile(folder_to_search, filelist(Readinfile).name);
  img_tmp = imread(File2Read);
  [a,b,c]=size(img_tmp);
    if c == 3
    sub_img = rgb2gray(img_tmp(405:660,149:404,:));
  else
    sub_img = img_tmp(405:660,149:404);
  end
  !sub_img = rgb2gray(img_tmp(405:660,149:404,:));
  ST_tmp = SpatialTraverse(sub_img, l, v);
  [s, ~] = SymbG(ST_tmp, Ub, Lb);
  IFS(s, size(Ub,1), 0.1 ,1);
  [IdxM, HRR, HMean, HVar, HSkew, HKurt, HEnt, HGini] = HRQA(s, size(Ub,1),1);
  Tmp_HRQA = horzcat(IdxM, HRR, HMean, HVar, HSkew, HKurt, HEnt, HGini);
  filename = filelist(Readinfile).name;filename = filename(1:end-4);
  File2Write = fullfile(folder_to_output, strcat(filename,'.csv'));
  csvwrite(File2Write,Tmp_HRQA);
end