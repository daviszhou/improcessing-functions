function im_adjusted = backgroundcorrection(im_roi, im_background, center, radius, has_adjustment_constant, has_disk_mask, show_figures)
% Background Correction corrects  uneven illumination in an retinal disk image
%   Correction is based on slice of the retina that does not contain pathology
%   By default, the choroid layer is used for the background
%   Optic disk is excluded from analysis and set as NaN

%% Show input figures
if show_figures
    figure(); imagesc(im_roi); colormap('gray'); axis('square'); title('ROI');
    figure(); imagesc(im_background); colormap('gray'); axis('square'); title('Background');
end

%% Create low pass version for calcuation of adjustment constant
im_roi_lp = imgaussfilt(im_roi, 5);
im_background_lp = imgaussfilt(im_background, 5);

if has_adjustment_constant
    
    if has_disk_mask
    % Exclude disk from analysis
    disk_mask = createCirclesMask(im_background, center/6, radius/6);

    % im_roi = imgaussfilt(im_roi, 2);
    % im_background = imgaussfilt(im_background, 2);
    im_roi = immultiply(im_roi, ~disk_mask);
    im_background = immultiply(im_background, ~disk_mask);

    im_roi_lp = immultiply(im_roi_lp, ~disk_mask);
    im_background_lp = immultiply(im_background_lp, ~disk_mask);
    end
    
    % Calculate adjustment constant
    im_roi_lp(isnan(im_roi_lp)) = 0;
    top = nanmean(im_roi_lp(:));
    im_background_lp(isnan(im_background_lp)) = 0;

    fraction = im_roi ./ im_background;

    % fraction(isnan(fraction)) = 0;
    bottom = nanmean(fraction(:));
    adjustment_constant = top / bottom;
    disp('Adjustment Constant is' + adjustment_constant)

    % Apply choroidal correction
    im_adjusted = im_roi ./ im_background .* adjustment_constant;
    
else
    im_adjusted = im_roi ./ im_background .* 150;
end

%% Show output figure
if show_figures
    figure(); imagesc(im_adjusted); colormap('gray'); axis('square'); title('Adjusted'); caxis([0 255])
end

end