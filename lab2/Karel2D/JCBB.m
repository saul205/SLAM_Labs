%-------------------------------------------------------
function H = JCBB (prediction, observations, compatibility)
% 
%-------------------------------------------------------
global Best;
global configuration;

Best.H = zeros(1, observations.m);

JCBB_R (prediction, observations, compatibility, [], 1);

H = Best.H;
configuration.name = 'JCBB';

%-------------------------------------------------------
function JCBB_R (prediction, observations, compatibility, H, i)
% 
%-------------------------------------------------------
global Best;
global configuration;

if i > observations.m % leaf node?
    if pairings(H) > pairings(Best.H) % did better?
        Best.H = H;
    end
else
    % complete JCBB here if A ==1  B = 2, else B = 3, end
    for j = 1:prediction.n
        if compatibility.ic(i, j) && jointly_compatible(prediction, observations, [H, j])
            JCBB_R(prediction, observations, compatibility, [H j], i + 1);
        end
    end

    if pairings(H) + observations.m - i > pairings(Best.H)
        JCBB_R(prediction, observations, compatibility, [H 0], i + 1);
    end
end

%-------------------------------------------------------
% 
%-------------------------------------------------------
function p = pairings(H)

p = length(find(H));