%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Polar Iterated Function System                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Description:                                                         %
%      Input a sequence of integers, then provide a set of IFS address   %
%      accordingly.                                                      %
% - Input:                                                               %
%         s: a sequence of integers                                      %
%         K: number of states (default: max(s))                          %
%         a: iterated parameter (default:0.9999*sin(pi/K)/(1+sin(pi/K))) %
% - Output:                                                              %
%         Theta: IFS addresses of s (theta)                              %
%         Rho: IFS addresses of s (rho)                                  %
% Authors:                                                               %
%         1. Cheng-Bang Chen    email: cbchen@chengbangchen.me           %
%         2. Hui Yang           email: huy25@psu.edu                     %
%         3. Soundar Kumara     email: skumara@psu.edu                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Theta, Rho] = PIFS(s, K, a, opt)
    if nargin < 4
       opt = 0; 
    end
    if nargin < 3
        if nargin < 2
            K = max(s);
        end
        a = 0.9999*sin(pi/K)/(1+sin(pi/K));
    end
    if isempty(a)
       a = 0.9999*sin(pi/K)/(1+sin(pi/K)); 
    end
     Cv = IFS(s, K, a);
    [Theta, Rho] = cart2pol(Cv(:,1), Cv(:,2));
    if opt > 0
        figure();
        plot(Theta,Rho,'.');
        %xlim([-2 2]);
        %ylim([-2 2]);
        title('Polar IFS address')
    end
end