%This function returns the member of the truss that will buckle first, the
%expected buckling strength and its length
%To be used in main.m; make sure they are in the same folder/directory

function [truss_max_load,critical_member_number, length_of_critical_member] = firstToBuckle2(C,X,Y,T,L)

%create a vector that only stores the tension of the member in compression,
%if member is in tension store its tension as 0
compression_member_vector = zeros(length(T)-3,1);
for i=1:length(compression_member_vector)
    if T(i) >0
        compression_member_vector(i) = 0;
    else
        compression_member_vector(i) = T(i);
    end
end


%Find the magnitude of the live load applied
load_index = find(L);
W_l_value=L(load_index);


%Find the length of all the members 
[~, member_nums] = size(C);
member_length_vector = zeros(length(compression_member_vector),1);
 for i = 1:member_nums
        indices = find(C(:,i));
        
    % Calculate the length for each member by finding the coordinate of the 2
    % joints making up the member, then using the norm function to find the
    % distance between those 2 joint
        point_1 = [X(indices(1)), Y(indices(1))];
        point_2 = [X(indices(2)), Y(indices(2))];
        member_length = norm(point_1 -point_2);
        member_length_vector(i)=member_length;
 end
 

 %Find the constant Rc for each member, only care about member in
 %compression
 member_rc_value_vector = zeros(length(compression_member_vector),1);
 for i=1:length(member_rc_value_vector)
     if compression_member_vector(i) ==0
         continue
     else
     rc_value=W_l_value/compression_member_vector(i);
     member_rc_value_vector(i) =rc_value;
     end
 end

 
 %Find the buckling force for each member based on its length, only care
 %about member in comporession
 member_buckling_force_vector = zeros(length(member_length_vector),1);
 for i=1:length(member_buckling_force_vector)
     buckling_force = 4338 * (member_length_vector(i) ^ (-2.125));
     member_buckling_force_vector(i) = buckling_force;
 end
 
 %Find the maximum theoretical load for each member, only care
 %about member in comporession. For tension force, set its max load value
 %to NaN
 member_max_load_vector = zeros(length(member_buckling_force_vector),1);
 for i=1:length(member_max_load_vector)
     if compression_member_vector(i) ==0
         member_max_load_vector(i) = NaN;
     else
     max_load = (member_buckling_force_vector(i)*-1)/ member_rc_value_vector(i);
     member_max_load_vector(i) = max_load;
     end
 end
 
 member_max_load_vector 
 %loop through the member_max_load_vector, the smallest value that is not
 %NaN will correspond to the critical member
 [smallest_value, smallest_index] = min(member_max_load_vector, [], 'omitnan');
 smallest_index = find(member_max_load_vector == smallest_value, 1, 'first');
 
 truss_max_load=smallest_value;
 critical_member_number = smallest_index;
 length_of_critical_member = member_length_vector(critical_member_number);
 end





