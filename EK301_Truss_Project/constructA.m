%This function receives the vectors and generate matrix A
%To be used in main.m; make sure they are in the same folder/directory

function A = constructA(C,Sx, Sy, X, Y)

%Get size of connection matrix C
[jointsNum, memberNums] = size(C);

%Initialize the upper and lower part of A (matrices for x and y force
%components)

Ax = zeros(jointsNum, memberNums);
Ay = zeros(jointsNum, memberNums);

% Calculate the force components for each member

    for i = 1:memberNums
    % Find the indices of the joints connected by the member by
    % creating a vector which stores the joint number that is connected to
    % that member
        indices = find(C(:,i))
        
    % Calculate the length for each member by finding the coordinate of the 2
    % joints making up the member, then using the norm function to find the
    % distance between those 2 joint
        point_1 = [X(indices(1)), Y(indices(1))];
        point_2 = [X(indices(2)), Y(indices(2))];
        member_length = norm(point_1 -point_2);
        
    % Calculate the coefficient and adding them to matrix Ax and Ay
        Ax(indices(1), i) = (X(indices(1)) - X(indices(2))) /  member_length;
        Ax(indices(2), i) = (X(indices(2)) - X(indices(1))) /  member_length;
        Ay(indices(1), i) = (Y(indices(1)) - Y(indices(2))) /  member_length;
        Ay(indices(2), i) = (Y(indices(2)) - Y(indices(1))) /  member_length;
    end

    % Concatenate Ax, Ay, Sx, and Sy into a single matrix A
    A = [Ax Sx; Ay Sy];
end
