% This script creates an image processing menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Margaux McFarland, CSC1 1320-112, ID: 107731341, Lab6/HW7
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Brighten Image','Invert Image','Add Random Noise','Luminance',...
    'Composite','Color Swap','Flag Collage','Binary Mask','Mean Filter');  % as you develop functions, add 
                                         % buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program',...
               'Load Image', 'Display Image', 'Brighten Image','Invert Image','Add Random Noise',...
               'Luminance','Composite','Color Swap','Flag Collage','Binary Mask','Mean Filter');  
                      % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1',...
               'wrench', 'yoda');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg'; 
               case 3
                   filename = 'wrench1.jpg'; 
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Brighten image
           
           choice2 = menu('Choose way to brighten','Loops','No Loops');
           
           switch choice2
               case 0
                     disp('Error - please choose one of the options.')
                    % Display a menu and get a choice
                    choice2 = menu('Choose way to brighten','Loops','No Loops');
               case 1
                   
                    %Loops
                    % 1. Ask the user for brightness value
                    brightness = input('By how much (-255,255) would you like to brighten the image?\n');
                    % create your own function for brightening
                    otherImage = makeBright_L(current_img,brightness);
                    % 3. Display the old and the new image using subplot
           
                    subplot(1,2,1);
                    imagesc(current_img);
           
                    subplot(1,2,2);
                    imagesc(otherImage);
                    if size(current_img,3) == 1
                        colormap gray
                    end
                    % 4. Save the newImage to a file
                    imwrite(otherImage,'brightened.png');
               case 2
                   %no loops
                   % 1. Ask the user for brightness value
                   brightness = input('By how much (-255,255) would you like to brighten the image?\n');
                   
                   
                   % 2. Call the appropriate function
                   
                   otherImage = makeBright_NL(current_img, brightness);
                   %display
                   
                   subplot(1,2,1);
                   imagesc(current_img);
                   
                   subplot(1,2,2);
                   imagesc(otherImage);
                   if size(current_img,3) == 1
                       colormap gray
                   end
                   % 4. Save the newImage to a file
                   imwrite(otherImage,'brightened.png');
           end
              
       case 5
           choice3 = menu('Choose way to invert','Loops','No Loops');
           
           switch choice3
               case 0
                     disp('Error - please choose one of the options.')
                    % Display a menu and get a choice
                    choice3 = menu('Choose way to invert','Loops','No Loops');
               case 1
                   
                    %Loops
                    
                    otherImage = invert_L(current_img);
                    % 3. Display the old and the new image using subplot
           
                    subplot(1,2,1);
                    imagesc(current_img);
           
                    subplot(1,2,2);
                    imagesc(otherImage);
                    if size(current_img,3) == 1
                        colormap gray
                    end
                    % 4. Save the newImage to a file
                    imwrite(otherImage,'inverted.png');
               case 2
                   %no loops
                   
                   otherImage = invert_NL(current_img);
                   %display
                   
                   subplot(1,2,1);
                   imagesc(current_img);
                   
                   subplot(1,2,2);
                   imagesc(otherImage);
                   if size(current_img,3) == 1
                       colormap gray
                end
                % 4. Save the newImage to a file
                imwrite(otherImage,'invertedNL.png');
           end
           
       case 6
           choice4 = menu('Choose way to add noise','Loops','No Loops');
           
           switch choice4
               case 0
                     disp('Error - please choose one of the options.')
                    % Display a menu and get a choice
                    choice4 = menu('Choose way to add noise','Loops','No Loops');
               case 1
                   
                    %Loops
                    
                    otherImage = addRandomNoise_L(current_img);
                    % 3. Display the old and the new image using subplot
           
                    subplot(1,2,1);
                    imagesc(current_img);
           
                    subplot(1,2,2);
                    imagesc(otherImage);
                    if size(current_img,3) == 1
                        colormap gray
                    end
                    % 4. Save the newImage to a file
                    imwrite(otherImage,'noisified.png');
               case 2
                   %no loops
                   
                   otherImage = addRandomNoise_NL(current_img);
                   %display
                   
                   subplot(1,2,1);
                   imagesc(current_img);
                   
                   subplot(1,2,2);
                   imagesc(otherImage);
                   if size(current_img,3) == 1
                       colormap gray
                   end
                   % 4. Save the newImage to a file
                   imwrite(otherImage,'noisifiedNL.png');
           end
           
       case 7
           choice5 = menu('Choose way to luminate','Loops','No Loops');
           
           switch choice5
               case 0
                     disp('Error - please choose one of the options.')
                    % Display a menu and get a choice
                    choice5 = menu('Choose way to add luminate','Loops','No Loops');
               case 1
                   
                    %Loops
                    colormap gray
                    otherImage = luminance_L(current_img);
                    % 3. Display the old and the new image using subplot
           
                    
                    
                    subplot(1,2,1);
                    imagesc(current_img);
           
                    subplot(1,2,2);
                    imagesc(otherImage);
                    
                    
                    
                    %  Save the newImage to a file
                    imwrite(otherImage,'luminated.png');
               case 2
                   %no loops
                   colormap gray
                   otherImage = luminance_NL(current_img);
                   %display
                   
                   subplot(1,2,1);
                   imagesc(current_img);
                   
                   subplot(1,2,2);
                   imagesc(otherImage);
                   
                   
                   
                   % 4. Save the newImage to a file
                   imwrite(otherImage,'luminatedNL .png');
           end
       case 8
           %composite image
           otherImage = composite(current_img);
           %display
           
           subplot(1,2,1);
           imagesc(current_img);
           
           subplot(1,2,2);
           imagesc(otherImage);
           
           % 4. Save the newImage to a file
           imwrite(otherImage,'composite.png');
       case 9
           %color swap
           
           %asks user to enter color values/ allowed range
           r1 = input('Enter a red value to be swapped: ');
           g1 = input('Enter a green value to swap: ');
           b1 = input('Enter a blue value to swap: ');
           r2 = input('Enter a red value to swap with r1: ');
           g2 = input('Enter a green value to swap with g1: ');
           b2 = input('Enter a blue value to swap with b1: ');
           
           allowed = input('Enter a value for leniency: ');
           
           otherImage = color_swap(current_img,r1,g1,b1,r2,g2,b2,allowed);
           %display
           
           subplot(1,2,1);
           imagesc(current_img);
           
           subplot(1,2,2);
           imagesc(otherImage);
           
           % 4. Save the newImage to a file
           imwrite(otherImage,'color_swapped.png');
       case 10
           %flag collage
           image1 = imread('eiffel1.jpg');
           image2 = imread('eiffel2.jpg');
           image3 = imread('eiffel3.jpg');
           
           otherImage = flag(image1,image2,image3);
           %display
           
           imagesc(otherImage)
           
           % 4. Save the newImage to a file
           imwrite(otherImage,'flag.png');
       case 11
           %binary mask
           
           otherImage = binaryMask(current_img);
           %display
           
           colormap gray
           
           
           subplot(1,2,1);
           imagesc(current_img);
           
           subplot(1,2,2);
           imagesc(otherImage);
           
           % 4. Save the newImage to a file
           imwrite(otherImage,'binary_mask.png');
           
       case 12
           %mean filter 
           %binary mask
           
           otherImage = meanFilter(current_img);
           %display
           
           subplot(1,2,1);
           imagesc(current_img);
           
           subplot(1,2,2);
           imagesc(otherImage);
           
           
           
           % 4. Save the newImage to a file
           imwrite(otherImage,'mean_filter.png');
           
           
           
       %....
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Brighten Image','Invert Image','Add Random Noise','Lumincance',...
    'Composite','Color Swap','Flag Collage','Binary Mask','Mean Filter'); 
   % as you develop functions, add buttons for them here
end
