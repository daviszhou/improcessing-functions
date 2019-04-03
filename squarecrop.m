function [output_image] = squarecrop(image, side_length)
    % Crop image into square given length of sides
    % Crops the boarders while centering the image
    % [matrix] = squarecrop(matrix, double)
    %
    % version davis 2019.01.25
    % TODO allow specification of center
    
    if ~isnumeric(side_length)
        error('Crop Error: crop side length must be input as a number');
    end
    
    disp(side_length)
    if (size(image,1) > side_length || size(image,2) > side_length)
        start_x = round((size(image,1) - side_length) / 2) + 1;
        start_y = round((size(image,2) - side_length) / 2) + 1;
        crop_length = side_length - 1;
        output_image = image(start_x:start_x+crop_length, start_y:start_y+crop_length);
        % disp(size(output_image)); %Debugging
    elseif (size(image,1) == side_length && size(image,2) == side_length)
        disp('Warning: input image has same demensions as crop size. No changes were made.')
        output_image = image;
    elseif (size(image,1) < side_length || size(image,2) < side_length)
        error('Crop Error: input image is smaller than crop size')
    else
        error('Crop Error: check squarecrop input image')
    end
end