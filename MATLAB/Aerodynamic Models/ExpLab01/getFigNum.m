function [f, sub, title_str, sgtitle_str] = getFigNum(i)
%getFigNum returns the figure number and subplot number
%   This function finds the corresponding figure number and position on a
%   subplot based on the test configuration. Figure based model tested and
%   speed tested at, and subplot positon based on downstream distance. Also
%   returns the corresponding title string.
%
%   Author: Margaux McFarland
%   Collaborators: 
%   Date: 10/19/19

        
    %all the downstream positions
    xpos_cyl = ["60" "90" "120" "150" "180" "210" "240"];
    xpos_air = ["13" "18" "23" "28" "33" "38" "43"];

    if i/7 <= 1 
        f = 1;
        sgtitle_str = "Cylinder at 15 m/s";
    elseif i/7 <= 2
        f = 2;
        sgtitle_str = "Cylinder at 25 m/s";
    elseif i/7 <=3
        f = 3;
        sgtitle_str = "Airfoil at 15 m/s";
    else
        f = 4;
        sgtitle_str = "Airfoil at 25 m/s";
    end
    
    sub = rem(i,7);
    if sub == 0
        sub = 7;
    end
    if f == 1 || f == 2
        title_str = xpos_cyl(sub) + "mm downstream";
    else
        title_str = xpos_air(sub) + "mm downstream";
    end
end