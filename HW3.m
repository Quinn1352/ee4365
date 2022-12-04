clc;
clearvars;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 1 %%%%%%%%%%%%%%%%%%%%%

q1partA = randn();

q1partB = randn();
q1partB = sqrt(0.1) * q1partB;
q1partB = 5 + q1partB;

q1partC = randn(10, 1);

q1partDa = randn();
q1partDa = 0.1 * q1partDa;
q1partDa = 5 + q1partDa;

q1partDb = randn();
q1partDb = 0.1 * q1partDb;
q1partDb = 5 + q1partDb;

q1partDc = rand(10, 1);
q1partDc = 0.1 .* q1partDc;
q1partDc = 5 + q1partDc;


%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 2 %%%%%%%%%%%%%%%%%%%%%

q2partA = rand();
q2partA = 20 * q2partA;
q2partA = -10 + q2partA;

q2partB = rand(10, 1);
q2partB = 20 * q2partB;
q2partB = 10 + q2partB;

q2partCa = rand();
q2partCa = -0.5 + q2partCa;

q2partCb = rand(10, 1);
q2partCb = -0.5 + q2partCb;

q2partDa = rand();
q2partDa = 2 * q2partDa;

q2partDb = rand(10, 1);
q2partDb = 2 * q2partDb;


%%%%%%%%%%%%%%%%%%%%%%%%% QUESTION 3 %%%%%%%%%%%%%%%%%%%%%

q3partA = exprnd(0.5);

q3partB = exprnd(1/3, 10, 1);

q3partC = exp((-1/3) * q3partB);



