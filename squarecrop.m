function [output_image] = squarecrop(image, output_side_length)
    % Crop image into square given length of sides
    % Crops the boarders while centering the image
    % [matrix] = squarecrop(matrix, double)
    
    if ~isnumeric(output_side_length)
        error('Crop Error: crop side length must be input as a number');
    end
    
    [image_length_x, image_length_y] = size(image);
    
    if (image_length_x > output_side_length || image_length_y > output_side_length)
        start_x = round((image_length_x/2 - output_side_length) / 2) + 1;
        start_y = round((image_length_y/2 - output_side_length) / 2) + 1;
        crop_length = output_side_length - 1;
        output_image = image(start_x:start_x+crop_length, start_y:start_y+crop_length);
        % disp(size(output_image)); %Debugging
    elseif (image_length_x == output_side_length && image_length_y == output_side_length)
        disp('Warning: input image has same demensions as crop size. No changes were made.')
        output_image = image;
    elseif (image_length_x < output_side_length || image_length_y < output_side_length)
        disp('Warning: input image is smaller than crop size. Image will be placed in a canvas with crop-size dimensions')
        
        larger_canvas=uint8(zeros(output_side_length, output_side_length));
        startpix_x=output_side_length/2 - image_length_x/2 + 1; % set x displacement
        startpix_y=output_side_length/2 - image_length_y/2 + 1; % set y displacement
        larger_canvas(startpix_x:startpix_x+image_length_x-1, startpix_y:startpix_y+image_length_y-1)=image;
        output_image=larger_canvas;
    else
        error('Crop Error: check squarecrop input image')
    end
end