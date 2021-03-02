function [mmperpix]=func_mm2pix_SedTrap_New(image_path, image_name)

pausetime=1.5;

   
    rgb=imread([image_path '\' image_name]); 
    
        %turn off warnings
    warning off all
    
    clf
    himg=imagesc(rgb); 
    %turn on warnings
    warning on all
    zoom on
    disp('------------------------------------------------------------------');
    disp(['Displaying image: ' image_name]);
    disp('Zoom in to measuring tape...');
    %zoom
    k=waitforbuttonpress;
    
    point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = abs(point1-point2);         % and dimensions
x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
    axis([min(x) max(x) min(y) max(y)])
    
    pause(pausetime);
   
    % prompts the user for the distance to divide by (defaults to 150mm)
   prompt={'What is the distance, in mm, you will measure?'};
   name='';
   numlines=1;
   defaultanswer={'150'};
    
   answer=inputdlg(prompt,name,numlines,defaultanswer); answer=char(answer);
   mm=str2num(answer);
    
    disp(['Click on two points, ',num2str(mm),' mm apart, then hit ENTER on the keyboard']);
    
    % allows for mistakes in ruler measuring
    [answer,x1,x2,y1,y2]=cycle;
                
    if numel(answer)==3
        disp('Calculating ....');
        [pixlength]=dist(x1,y1,x2,y2);
        mmperpix=mm/pixlength;
    else
        while numel(answer)~=3
           [answer,x1,x2,y1,y2]=cycle;
        end
        [pixlength]=dist(x1,y1,x2,y2);
        mmperpix=mm/pixlength;
    end

    
%--------------------------------------------------------------------------
function [d]=dist(x1,y1,x2,y2)
%DISTANCE calculates the distance between two coordinate pairs
%   USAGE:[distance]=distance(x1,y1,x2,y2)
%
d=sqrt(((x2-x1).*(x2-x1))+((y2-y1).*(y2-y1)));

%--------------------------------------------------------------------------


function [answer,x1,x2,y1,y2]=cycle

d=ginput(2); d=d(:);
x1=d(1); x2=d(2); y1=d(3); y2=d(4);
 
hold on, h=line([x1 x2],[y1 y2]); 
set(h,'Color','r','LineWidth',3)
    
answer = questdlg('Are you happy with this selection?', ...
                    'Question', 'Yes');