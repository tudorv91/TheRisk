n = 100;
att = zeros(n,1);
def = zeros(n,1);

for j = 1:20
    for k = 1:20
        for i = 1:n
            [att(i),def(i)]=rollDice(5,5);
        end
        pd_att = fitdist(att,'Normal');
        pd_def = fitdist(def,'Normal');
        mu_att(j,k) = pd_att.mu;
        mu_def(j,k) = pd_def.mu;
        sigma_att(j,k) = pd_att.sigma;
        sigma_def(j,k) = pd_def.sigma;
        j
        k
    end
end

 plot(mu_att*inv(mu_def))
 hold on