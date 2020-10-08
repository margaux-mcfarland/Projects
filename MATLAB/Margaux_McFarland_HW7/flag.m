function [outImg] = flag(inImg1,inImg2,inImg3)
inImg1 = uint8(inImg1);
inImg2 = uint8(inImg2);
inImg3 = uint8(inImg3);


[r1,c1,l1] = size(inImg1);
[r2,c2,l2] = size(inImg2);
[r3,c3,l3] = size(inImg3);



%get smallest image dimensions
if r1 < r2 && r1 < r3
    r = r1;
elseif r2 < r1 && r2 < r3
    r = r2;
else
    r = r3;
end

if c1 < c2 && c1 < c3
    c = c1;
elseif c2 < c1 && c2 < c3
    c = c2;
else
    c = c3;
end

if l1 < l2 && l1 < l3
    l = l1;
elseif l2 < l1 && l2 < l3
    l = l2;
else
    l = l3;
end





outImg = inImg1;


for k = 1:l
    for i = 1:r
        for j = 1:c
            if j < c/3
                outImg(i,j,k) = inImg1(i,j,k);
                outImg(i,j,3) = 255;
            elseif j < 2*c/3
                outImg(i,j,k) = inImg2(i,j,k);
                outImg(i,j,2) = 255;
            else
                outImg(i,j,k) = inImg3(i,j,k);
                outImg(i,j,1) = 255;
            end
        end
    end
end


  
    
end
