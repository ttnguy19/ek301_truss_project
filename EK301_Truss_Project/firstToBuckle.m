%This function returns the member of the truss that will buckle first, the
%expected buckling strength and its length
%To be used in main.m; make sure they are in the same folder/directory

function [bucking_value,max_Index, length_of_member] = firstToBuckle(C,X,Y,T)

%Create a vector that stores only the member that are in compression. If
%they are in tension (positive), turns them into zero. If they are in
%compression (negative), input them in the vector as positive
compression_member = zeros((length(T)-2),1);

for i = 1: length(compression_member)
    if T(i)> 0
        compression_member(i) = 0;
    else
        compression_member(i) = abs(T(i));
    end
end

%Create a vector for the member length
member_length_vector = zeros((length(T)-2),1);

    %Create a vector that will store the ratio between the compression
    %force and its breaking point, the higher this ratio, the more likely
    %that the member will buckle
breaking_point_ratio = zeros((length(T)-2),1);

for i = 1:length(C)
    
    % Find the indices of the joints connected by the member by
    % creating a vector which stores the joint number that is connected to
    % that member
        indices = find(C(:,i));
    % Calculate the length for each member by finding the coordinate of the 2
    % joints making up the member, then using the norm function to find the
    % distance between those 2 joint
        point_1 = [X(indices(1)), Y(indices(1))];
        point_2 = [X(indices(2)), Y(indices(2))];
        member_length = norm(point_1 -point_2);
        member_length_vector(i) = member_length;
        
    %Find the breaking point for each member
        breaking_point = 4338 * member_length ^ (-2.125);
        
    %Find the ratio then add to breaking point ratio vector
        breaking_point_ratio(i) = compression_member(i) / breaking_point;
    
end    
    %The index of the maximum member will the member # that will buckle
    %first
    [~, max_Index] = max(breaking_point_ratio);
    
    %Find the expected buckling strength
    bucking_value = 4338 * member_length_vector(max_Index) ^ (-2.125);
    
    %Find the length of the first member to buckle
    length_of_member = member_length_vector(max_Index);
 end