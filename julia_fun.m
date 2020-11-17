total_it=300; %we will iterate a given function a reasonably large number of times
img_size=[1000 1000]; %number of values that we wish to iterate
lims=[-5 5 -5 5]; %set the limits for our plot of the filled Julia set
im_step=(lims(4)-lims(3))/(img_size(2)-1); %increments 'along' real axis
re_step=(lims(2)-lims(1))/(img_size(1)-1); %increments 'along' imaginary axis

%these are all the values of 'z' that we apply the given function to

%these are the real parts of these values
res=lims(1):re_step:lims(2); 
%imaginary parts of these values
ims=lims(3):im_step:lims(4);
%create the values of z
z=bsxfun(@plus, res(:), (ims(:)*1i)');
colour=inf(size(z)); %this is a matrix that will 'encode' the colour of the Julia set at a given point (value)

for iteration=1:total_it
    %determine which values are 'close to infinity' and which are not
    index=isinf(z);
    %apply the function to those values which are 'less than infinity';
    %this function is the one whose filled Julia set is given in Figure
    %11(d); note that this function can be changed to plot the filled Julia set of another function
    z(~index)=(z(~index)+(1/((5)^(1/4)))).^5-(1/((5)^(5/4)));
    %ensure that the colour of the plot at a given point(value) depends on
    %number of iterations taken to reach 'infinity'
    colour(index & isinf(colour))=iteration;
end

%ensure that the real parts of values are on the horizontal axis
colour=colour';

%plotting the graph, with correct values shown on the x and y axes
imagesc('XData',[lims(1),lims(2)],'YData',[lims(3),lims(4)],'CData',colour)
