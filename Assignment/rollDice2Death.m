function [attArmyEnd, defArmyEnd] = rollDice2Death(attArmy,defArmy)
% fight to the death dice roll
if attArmy == 0
   disp('[rollDice] You just tried to attack with 0 armies')
elseif defArmy == 0
   disp('[rollDice] You just tried to attack a country with 0 armies')
else

while attArmy ~= 0 && defArmy ~= 0
switch attArmy
    case 1
        switch defArmy
            case 1
                attArmyWin = sum(rand() > cumsum([21/36 15/36]));
                defArmy = defArmy - attArmyWin;
                attArmy = attArmy -1 + attArmyWin;
            otherwise
                attArmyWin = sum(rand() > cumsum([161/216 55/216]));
                defArmy = defArmy - attArmyWin;
                attArmy = attArmy -1 + attArmyWin;
        end     
    case 2
        switch defArmy
            case 1
                attArmyWin = sum(rand() > cumsum([91/216 125/216]));
                defArmy = 1 - attArmyWin;
                attArmy = attArmy - 1 + attArmyWin;
            otherwise
                attArmyWin = sum(rand() > cumsum([581/1296 420/1296 295/1296]));
                defArmy = defArmy - attArmyWin;
                attArmy = attArmy -1 + attArmyWin;
        end     
        
    otherwise
        switch defArmy
            case 1
                attArmyWin = sum(rand() > cumsum([441/1296 855/1296]));
                defArmy = 1 - attArmyWin;
                attArmy = attArmy - 2 + attArmyWin;
            otherwise
                attArmyWin = sum(rand() > cumsum([2275/7776 2611/7776 2890/7776]));
                defArmy = defArmy - attArmyWin;
                attArmy = attArmy - 2 + attArmyWin;
        end     
end
end
end

attArmyEnd = attArmy;
defArmyEnd = defArmy;


end
