close all
clear all
clc

syms x y
f =x^2-y
g = gradient(f, [x, y])

[X, Y] = meshgrid(-0.9:.1:0.9,-1:.1:1);
G1 = subs(g(1), [x y], {X,Y});
G2 = subs(g(2), [x y], {X,Y});
F = subs(f, [x y], {X,Y});
quiver(X, Y, G1, G2)
hold on
