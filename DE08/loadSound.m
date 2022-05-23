function [bomb,gunR,gunB,airplane,planeBoom,soundtrack, bombFs,gunFsR,gunFsB,airplaneFs, planeBoomFs,soundtrackFs]=loadSound()
[bomb,bombFs] = audioread('sounds/soundBoom2.wav');

[gunR,gunFsR] = audioread('sounds/soundgun.wav');
% gun=gun(1:3*gunFs);

[gunB,gunFsB] = audioread('sounds/soundgun2.wav');
% fight=fight(1:20*fightFs);
[airplane,airplaneFs] = audioread('sounds/airplane.wav');

[planeBoom,planeBoomFs] = audioread('sounds/planeBoom.wav');

[soundtrack,soundtrackFs] = audioread('sounds/avengers.mp3');
% soundtrack=soundtrack(1:2*soundtrackFs);