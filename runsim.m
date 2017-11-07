close all;
clear;

trajhandle = @trajectory_generator;
controlhandle = @controller;

[t,s] = simulation(trajhandle,controlhandle);