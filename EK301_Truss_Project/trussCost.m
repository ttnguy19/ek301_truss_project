%This function returns the cost of the truss design
function cost = trussCost(C, X, Y)
[jointsNum, memberNums] = size(C);
total_length = 0;
  for i = 1:memberNums
    % Find the indices of the joints connected by the member by
    % creating a vector which stores the joint number that is connected to
    % that member
        indices = find(C(:,i));
        
    % Calculate the length for each member by finding the coordinate of the 2
    % joints making up the member, then using the norm function to find the
    % distance between those 2 joint
    % Then add them together to find the total length 
        point_1 = [X(indices(1)), Y(indices(1))];
        point_2 = [X(indices(2)), Y(indices(2))];
        member_length = norm(point_1 -point_2);
        total_length = total_length + member_length;
  end

  cost = 10* jointsNum + 1*total_length;
end
