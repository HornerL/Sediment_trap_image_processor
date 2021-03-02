function a = col2gray(r,g,b)
%COL2GRAY Convert RGB image or colormap to grayscale.
%   COL2GRAY converts RGB images to grayscale by eliminating the
%   hue and saturation information while retaining the
%   luminance.
%
%   I = COL2GRAY(RGB) converts the truecolor image RGB to the
%   grayscale intensity image I.


if nargin==0,
  error('Need input arguments.');
end
threeD = (ndims(r)==3); % Determine if input includes a 3-D array 

if nargin==1,
  if threeD,
    rgb = reshape(r(:),size(r,1)*size(r,2),3);
    a = zeros([size(r,1), size(r,2)]);
  else % Colormap
    rgb = r;
    a = zeros(size(r,1),1);
  end

elseif nargin==2,
  error('Wrong number of arguments.');

elseif nargin==3,
  warning(['COL2GRAY(R,G,B) is an obsolete syntax.',...
    'Use a three-dimensional array to represent RGB image.']);
  if (any(size(r)~=size(g)) | any(size(r)~=size(b))),
    error('R, G, and B must all be the same size.')
  end
  rgb = [r(:), g(:), b(:)];
  a = zeros(size(r));
else
  error('Invalid input arguments.');
end

T = inv([1.0 0.956 0.621; 1.0 -0.272 -0.647; 1.0 -1.106 1.703]);

if isa(rgb, 'uint8')  
    a = uint8(reshape(double(rgb)*T(1,:)', size(a)));
elseif isa(rgb, 'uint16')
    a = uint16(reshape(double(rgb)*T(1,:)', size(a)));
elseif isa(rgb, 'double')    
    a = reshape(rgb*T(1,:)', size(a));
    a = min(max(a,0),1);
end

if ((nargin==1) & (~threeD)),    % col2gray(MAP)
    if ~isa(a, 'double')
        a = im2double(a);
    end
    a = [a,a,a];
end

