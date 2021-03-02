close all
clearvars

% Script to manually measure the height of sediment in digital photos of a sediment trap
% Modified from Daniel Buscombe's 2009 Cobble Cam digital pebble count script by Liam Horner (WWU), 2020
%% Step 1:  Get Photos

fol = uigetdir; % This is the folder that houses all of the photos you want.  As long as the folder is within the working directory you'll be fine, otherwise include the full directory path
fn  = dir([fol '/*.jpg']); % This will list any and all files within my 'fol' variable that end in .jpg - you can do the same for files that end in .txt or .mat for example
% This outputs a structure data type  with all of the files, the path to
% them, etc.
% So to access them you would do something like: f(1).name or f(ii).name 
pn  = fn(1).folder;
%% Step 2:  Set Parameters and prep output

n=1;
output=[]; %prep output

%output file
% % % % % % % xlswrite('SedHeightOutput.xls',{'Filename','Date Taken','Time Taken','Easting (m)','Northing (m)','Pix2mm Conversion','Height(mm)','Point Estimate (pix)'},1,'A1')
% % % % % % % xlswrite('SedHeightOutput.xls',fn(1).name,1,'A2')

%% Step 3:  Process

% pixels_2_mm conversion (assumes all photos being processed have the same scale)
% can be entered manually if known, or extracted from a scale in the image
prompt={'If you know the conversion factor of mm/pixel for your photos, enter it here. If not, enter 0'};
name='';
numlines=1;
defaultanswer={'0.143'};

answer=inputdlg(prompt,name,numlines,defaultanswer); answer=char(answer);
mm=str2num(answer);

if  mm~=0
    conv=mm
else
    conv(1,1)=func_mm2pix_SedTrap_New(pn,fn(1).name);
end

for ii=1:length(fn)
    
    % select zoom level for photo
    close
    rgb = imread([pn '\' fn(ii).name]);
    image(rgb)
    clc
    siz(ii)=1;
    
    %get and add date?
    info = imfinfo([pn '\' fn(ii).name]);
    DateTime = info.DateTime;
    % record the datetime into a structure 
    fn(ii).dtm = DateTime;
    
    %run point count function
    C=eyeball_SedTrapHeight([pn '\' fn(ii).name],n,siz(ii));
    % record to structure 
    fn(ii).c = C;
    
    %add results to output
    output=[output; C'];
    
    clear C
    
end



%% Now that we have all of the data we want let's write it out to a CSV file which can easily be opened as an Excel File
% % % % % % % xlswrite('SedHeightOutput.xls',{'Filename','Date Taken','Time Taken','Easting (m)','Northing (m)','Pix2mm Conversion','Height(mm)','Point Estimate (pix)'},1,'A1')
fname = 'SedHeightOutput.csv';
fid   = fopen(fname,'w'); % open the file in 'write' mode, can do the same for reading files setting it to 'r'

% Let's write the header 
fprintf(fid,'Filename,Date Taken,Time Taken,DD North,DD West,Pix2mm Conversion,Height(mm),Point Estimate (pix)\n');
for ii = 1:length(fn)
    fprintf(fid,'%s,%s,%s,%s,%s,%s,%s,%s\n',fn(ii).name,sprintf('%s/%s/%s',fn(ii).dtm(6:7),fn(ii).dtm(9:10),fn(ii).dtm(1:4)),...
        fn(ii).dtm(12:end),'','',num2str(conv),num2str(conv*fn(ii).c),num2str(fn(ii).c));
end
fclose(fid);
return
%% EOF 



