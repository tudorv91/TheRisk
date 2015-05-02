close all

p1 = randi([0 1], 42, 8);
p2 = randi([0 1], 42, 8);

p1_fit = rand/2;
p2_fit = rand/2;

child = evolve(p1, p2, p1_fit, p2_fit, 0.1);

figure;
subplot(311),
imagesc(bi2de(p1)')
subplot(312),
imagesc(bi2de(p2)')
subplot(313),
imagesc(bi2de(child)'),
colormap(gray)
;
