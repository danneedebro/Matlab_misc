function [x_coarse,y_coarse] = CoarsenXYData(x,y,tol)
%CoarsenXYData Function that coarsen xy-data
%   [x_coarse,y_coarse] = CoarsenXYData(x,y,tol) returns x_coarse, and
%   y_coarse that satisfies that a linear interpolation between this coarse
%   representation reproduces y within the tolerance
%   (i.e interp1(x_coarse,y_coarse,x(i)) = y(i) +- tol
%
%   Example:
%      x = 0:0.01:2*pi;
%      y = sin(x);
%      [x_new,y_new] = CoarsenXYData(x,y,0.01)
%      plot(x,y,'-',x_new,y_new,'o')
%
    points_used=zeros(size(x));
    points_used(1)=1;
    points_used(end)=1;

    refinement_made = 1;
    while refinement_made == 1

        % Find the indexes of the points used
        pos = find(points_used==1);

        % Flag to check if refinement made in current loop
        refinement_made = 0;

        % Loop through these points and check if points inbetween is
        % sufficiently approximated using linear interpolation
        for i=1:length(pos)-1
            ind_1=pos(i);
            ind_2=pos(i+1);
            x_1=x(ind_1);
            x_2=x(ind_2);
            y_1=y(ind_1);
            y_2=y(ind_2);
            y_vec = y_1+(y_2-y_1)/(x_2-x_1)*(x(ind_1:ind_2)-x_1);
            err = abs(y_vec-y(ind_1:ind_2));

            % If err larger than tolerance, add point in between ind1 and ind2
            if max(err) > tol && ind_2-ind_1>1
                refinement_made = 1;
                ind_new = ind_1+floor((ind_2-ind_1)/2);
                points_used(ind_new)=1;
            end
        end
    end

    indexes_used=find(points_used==1);
    x_coarse = x(indexes_used);
    y_coarse = y(indexes_used);
end