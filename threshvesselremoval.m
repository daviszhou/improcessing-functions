function image_output = threshvesselremoval(image_input, vessels_image_input)
% ThreshVesselRemoval removes vessels from image based on bradley local thresholding
% matrix = threshvesselremoval(matrix, matrix)

debugging = false;

vessels_image_input = im2double(vessels_image_input);
vessels_image_input = squeeze(vessels_image_input(:,:,1));

vessel_mask = bradley(vessels_image_input);
vessel_mask = ~vessel_mask;

if debugging
    figure(); imagesc(vessel_mask); colormap gray; axis image; axis off; title('1');
    vessel_mask = bwareaopen(vessel_mask, 10);
    figure(); imagesc(vessel_mask); colormap gray; axis image; axis off; title('1');
    vessel_mask = bwareaopen(vessel_mask, 14);
    figure(); imagesc(vessel_mask); colormap gray; axis image; axis off; title('1');
    vessel_mask = bwareaopen(vessel_mask, 16);
    figure(); imagesc(vessel_mask); colormap gray; axis image; axis off; title('1');
else
    vessel_mask = bwareaopen(vessel_mask, 16);
end

se = strel('disk', 4);
vessel_mask = imdilate(vessel_mask, se);

if debugging
    figure(); imagesc(vessel_mask); colormap gray; axis image; axis off; title('Initial Vessels Mask');
end

image_output = immultiply(~vessel_mask, image_input);

end

