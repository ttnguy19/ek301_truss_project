%EK301, section A4, Group 18: Thinh Nguyen, Emma Stone, Matthew Luponio

%This is the main file of the analysis

%SECTION 1: CALCULATION

%Load data from input file
inputFile = 'SampleTrussProblem_ThinhEmmaMatthew.mat';
data = load(inputFile);

C = data.C;
Sx = data.Sx;
Sy = data.Sy;
X = data.X;
Y = data.Y;
L = data.L;

%Construct matrix A
A = constructA(C,Sx, Sy, X, Y);

%Invert matrix A and calculate vector T
invA = inv(A);
T = invA * L;

%Calculate truss cost
cost = trussCost(C, X, Y);

%Find first member to buckle
%[bucking_value,max_Index, length_of_member] = firstToBuckle(C,X,Y,T);

[truss_max_load,critical_member_number, length_of_critical_member] = firstToBuckle(C,X,Y,T,L);


%SECTION 2: OUTPUT OF RESULTS

fprintf('EK301, section A4, Group 18: Thinh Nguyen, Emma Stone, Matthew Luponio \n')

load_index = find(L);
fprintf('Load: %d oz \n', L(load_index));

%Print out member forces
fprintf('Member forces in oz \n');
for i=1:(length(T)-3)
    if T(i) < 0
        fprintf('m%d: %.3g (C) \n', i, abs(T(i)));
    elseif T(i) == 0
        fprintf('m%d: 0.00 \n', i, abs(T(i)));
    else
        fprintf('m%d: %.3g (T) \n', i, abs(T(i)));
    end
end

%Print out the first member to buckle, its expected buckling strength and
%its length
fprintf('First member to buckle: \n');
expected_buckling_strength = 4338 * (length_of_critical_member ^ (-2.125));
fprintf('m%d with a length of %.3g in and an expected buckling strength of %.3g oz \n', critical_member_number,length_of_critical_member,expected_buckling_strength);

%Print out reaction forces 
fprintf('Reaction forces in oz \n');
fprintf('Sx1: %.3g \n', T(length(T)-2));
fprintf('Sy1: %.3g \n', T(length(T)-1));
fprintf('Sy2: %.3g \n', T(length(T)));
  
%Print the maximum theoretical truss load
fprintf('The maximum theoretical truss load is %.3g oz \n', truss_max_load);
%Print the cost of truss design
fprintf('Cost of truss: $%.3g \n', cost);

load_to_cost = truss_max_load/cost;
%Print the cost of truss design
fprintf('Load-to-cost ratio: %.3g \n',load_to_cost );




