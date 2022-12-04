clear
close all
clc

%%%%%%%%%%%%% PROBLEM 1 %%%%%%%%%%%%%%%%%%%%%%

%problem 1, question 1
P1_1 = rand(10, 1) < 0.45;
P1_1 = -1 * P1_1;

%problem 1, question 2
P1_2 = rand(10, 1);
P1_2temp = P1_2 > 0.6; %generate 1 with probability 0.4
P1_2 = P1_2 < 0.4; 
P1_2 = P1_2 * -1; %generate -1 with probability .4
P1_2 = P1_2 + P1_2temp; %anything not 1 or -1 left as 0
clear p1_2temp; %clean up variables that aren't answers

%problem 1, question 3
L = 128; %length of each
s = ones(L, 1); %variable to shorten answer lines
P1_3S_1 = (s + j*s)/ sqrt(2*L);
s = [ones(L/4, 1); -ones(L/4, 1); ones(L/4, 1); -ones(L/4, 1)];
P1_3S_2 = (s + j*s) / sqrt(2*L);
s = [-ones(L/4, 1); -ones(L/4, 1); ones(L/4, 1); ones(L/4, 1)];
P1_3S_3 = (s+ j *s) / sqrt(2*L);
s = [ones(L/4, 1); -ones(L/4, 1); -ones(L/4, 1); ones(L/4, 1)];
P1_3S_4 = (s + j*s) / sqrt(2*L);
%each S must have an equal number of same sign and different sign bits as
%each other S in order to satisfy Sm' * Sn = 0 for m not = n
clear L s;

%problem 1, question 4
 