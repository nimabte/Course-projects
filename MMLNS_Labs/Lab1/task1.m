%using the cell array construction operator
A0 = {[1 4 3; 0 5 8; 7 2 9],'Anne Smith';
      3+7i, -pi:pi/10:pi};
  
%unsing content indexing
A(1,1) = {[1 4 3; 0 5 8; 7 2 9]};
A(1,2) = {'Anne Smith'};
A(2,1) = {3+7i};
A(2,2) = {-pi:pi/10:pi};

%display cell
A
celldisp(A)