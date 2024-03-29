function [output_image, added_borders] = squarecrop(image, output_side_length)
    % Crops input image into a square with defined side-length
    % Adds black borders if crop size is larger than image dimensions
    % Maintains the center of the image
    % [matrix] = squarecrop(matrix, double)
    
    if ~isnumeric(output_side_length)
        error('Crop Error: crop side length must be input as a number');
    end
    
    [image_length_x, image_length_y] = size(image);
    added_borders = [];
    
    if (image_length_x > output_side_length && image_length_y > output_side_length)
        start_crop_x = round(image_length_x/2 - output_side_length/2 + 1);
        start_crop_y = round(image_length_y/2 - output_side_length/2 + 1);
        crop_length = output_side_length - 1;
        output_image = image(start_crop_x : start_crop_x+crop_length, start_crop_y : start_crop_y+crop_length);
        % disp(size(output_image)); %Debugging
    elseif (image_length_x == output_side_length && image_length_y == output_side_length)
        disp('Warning: input image has same demensions as crop size. No changes were made.')
        output_image = image;
    elseif (image_length_x < output_side_length || image_length_y < output_side_length)
        disp('Warning: input image is smaller than crop size. Image will be placed in a canvas with crop-size dimensions')
        larger_side_length = max([image_length_x, image_length_y, output_side_length]);
        larger_canvas = uint8(zeros(larger_side_length, larger_side_length));
        larger_canvas_borders = uint8(ones(larger_side_length, larger_side_length));
        
        start_border_x = larger_side_length/2 - image_length_x/2 + 1; % set x displacement
        start_border_y = larger_side_length/2 - image_length_y/2 + 1; % set y displacement
        larger_canvas(start_border_x : start_border_x+image_length_x-1, start_border_y : start_border_y+image_length_y-1) = image;
        larger_canvas_borders(start_border_x : start_border_x+image_length_x-1, start_border_y : start_border_y+image_length_y-1) = 0;
        added_borders = larger_canvas_borders;
        
        if image_length_x > output_side_length || image_length_y > output_side_length
            start_crop_x = round(image_length_x/2 - output_side_length/2 + 1);
            start_crop_y = round(image_length_y/2 - output_side_length/2 + 1);
            crop_length = output_side_length - 1;
            output_image = larger_canvas(start_crop_x : start_crop_x+crop_length, start_crop_y : start_crop_y+crop_length);
        else
            output_image = larger_canvas;
        end
    else
        error('Crop Error: check squarecrop input image')
    end
end