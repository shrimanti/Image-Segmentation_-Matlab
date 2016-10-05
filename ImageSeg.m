close all;
clear all;

img = double(imread('10.png'));

L = 256;

img(:) = round((L-1)*(img(:)-min(img(:)))/(max(img(:))-min(img(:))));
figure(1), imagesc(img), colormap(gray), axis image;

Ih = size(img,1);
Iw = size(img,2);

F = zeros(Ih,Iw);
B = zeros(Ih,Iw);
P = zeros(Ih,Iw);
f = zeros(L,1);


% foreground rectangle
[x,y,button] = ginput(2);
x1 = round(min(x));
x2 = round(max(x));
y1 = round(min(y));
y2 = round(max(y));

% draw rectangle
figure(1), hold on;
plot([x1 x2 x2 x1 x1], [y1 y1 y2 y2 y1],'g');

% initialize F
F(y1:y2,x1:x2) = 1;



% background rectangle
[x,y,button] = ginput(2);
x1 = round(min(x));
x2 = round(max(x));
y1 = round(min(y));
y2 = round(max(y));

% draw rectangle
figure(1), hold on;
plot([x1 x2 x2 x1 x1], [y1 y1 y2 y2 y1], 'r');

% initialize B
%                                                                                                                                                               
B(y1:y2,x1:x2) = 1; 

figure(2),imagesc(F),colormap(gray),axis image;

figure(3),imagesc(B),colormap(gray),axis image;


h=hist(img(:),L);
figure(4), plot(h);

sig = 6;
g = fspecial('Gaussian',[2*round(3*sig)+1 1],sig);

hc = conv(h,g,'same');
figure(4), hold on, plot(hc,'r'), hold on;

%Initialization of P
P(:) = 0.5;
P(logical(F)) = 1;
P(logical(B)) = 0;

%figure(5),imagesc(P),colormap(gray),axis image;  
                         

for itr = 1:100,
    f(:)=0;
    for i = 1:Ih
        for j = 1:Iw
            v = img(i,j) + 1;
            f(v) = f(v) + P(i,j);
        end
    end
    
    fc = conv(f,g,'same');
    
    for i = 1:Ih
        for j = 1:Iw
            if F(i,j)==0 && B(i,j)==0
                P(i,j) = fc(img(i,j)+1)/hc(img(i,j)+1);
            end
        end
    end
    
 figure(6),imagesc(P),colormap(gray),axis image; 
          
end

figure(7),imagesc(P>=0.5),colormap(gray),axis image; 



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


    
