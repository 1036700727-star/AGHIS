clear all
addpath(genpath('.'));

FileName = 'qsar_oral_toxicity';
load([FileName,'.mat'])

X = data;
Y = label;

X = Norm(X);


eta = 0.001;
rho = 1;


for i = 1:5

    ID = randperm(length(Y));

    Predict{i} = run_AGHIS(Y, X, ID, eta, rho);

end