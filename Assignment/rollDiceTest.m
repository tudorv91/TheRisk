format compact
close all
clear
clc


n = 500;

pr_win = zeros(20,20);
mu_att = zeros(20,20);
mu_def = zeros(20,20);
sigma_att = zeros(20,20);
sigma_def = zeros(20,20);

for j = 1:20
    for k = 1:20
        winner = zeros(n,1);
        att = zeros(n,1);
        def = zeros(n,1);
        for i = 1:n
            [att(i),def(i)]=rollDice(j,k);
            if def(i)==0
                winner(i)=1;
%                 disp('has won')
%             else
%                 disp('has lost')
            end
        end
        pd_att = fitdist(att,'Normal');
        pd_def = fitdist(def,'Normal');
%         disp(sum(winner))
        pr_win(j,k) = sum(winner)/n;
        mu_att(j,k) = pd_att.mu;
        mu_def(j,k) = pd_def.mu;
        sigma_att(j,k) = pd_att.sigma;
        sigma_def(j,k) = pd_def.sigma;
    end
    disp(j/20*100)
end

 surf(meshgrid(1:20),meshgrid(1:20)',pr_win)
 hold on