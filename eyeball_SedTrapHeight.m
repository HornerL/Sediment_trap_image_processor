function C=eyeball_SedTrapHeight(im,n,split,filter)
close all

% function to manually measure height of sediment in an image of a sed trap
%
% INPUTS
% im = digital image or image filename
% 
% 'filter' is either left empty (for none), 'zeroavg' for zer0-averaging the columns, 
% or 'gamma' for gamma-correction to make image look brighter
%
% The figure window is automatically maximised
%
% Top and bottom of sediment column are identified by the user using a cursor.
%
% OUTPUT
% C= vector of counted sediment heights, in pixels
%
% Modified by Liam Horner, 2020, from Daniel Buscombe's 2009 Cobble Cam script

if ~isnumeric(im)
im=double(col2gray(imread(deblank(im))));
end

if nargin==3 % i.e. if not filter is defined
    filter='none';
end

if strcmp(filter,'zeroavg');
  
    [m,n,o]=size(im);
    if o>1
    im=eyeball_zeroavg(im); 
    else
    disp('zero-averaging only on rgb images')    
    end
elseif strcmp(filter,'gamma');
    im=eyeball_gamma(im);
end
  
        C=[];
    
        imagesc(im), axis image
        colormap gray
        grid on
        set(gca,'GridLineStyle','-')
        hold on, 
        maximise
        
        answer = questdlg('Can sed height be measured in this picture?','Measurment prompt', 'yes','no','height = 0mm','yes')
            for i=1:n
                if strcmp(answer,'yes')
                    a=ginput(2); % two points
                    C=[C;ceil(sqrt(diff(a(:,1))^2+diff(a(:,2))^2))];
                elseif strcmp(answer,'no')
                    C = [C;NaN];
                else 
                    C = [C;0];
                end
            
            close

end

 function maximise

units=get(gcf,'units');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gcf,'units',units)
         