%EK301, section A4, Group 18: Thinh Nguyen, Emma Stone, Matthew Luponio

%This is the main file of the analysis
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

%Invert matrix A
invA = inv(A);

T = invA * L;


