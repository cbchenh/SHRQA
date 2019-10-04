%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iterated Function System                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% - Description:                                                         %
%      Input a sequence of integers, then provide a set of IFS address   %
%      accordingly.                                                      %
% - Input:                                                               %
%         s: a sequence of integers                                      %
%         K: number of states (default: max(s))                          %
%         a: iterated parameter (default:0.9999*sin(pi/K)/(1+sin(pi/K))) %
% - Output:                                                              %
%         Cv: IFS addresses of s                                         %
%                                                                        %
% Author: Cheng-Bang Chen                                                %
%         cbchen@chengbangchen.me                                        %
%         09/19/2019                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Cv] = IFS(s, K, a)
    if isempty(s)
        error('The input sequence, s, is empty.')
    end
    s = reshape(s,[length(s) 1]);
    if nargin < 3
        if nargin < 2
            K = max(s);
        end
        a = 0.9999*sin(pi/K)/(1+sin(pi/K));
    end
    Cv = [0, 0];
    for i = 1:length(s)
        Cv(i+1,:) = [a*Cv(i,1)+cos(2*pi*s(i)/K),a*Cv(i,2)+sin(2*pi*s(i)/K)];
    end
    figure();
    plot(Cv(:,1),Cv(:,2),'.');
    xlim([-2 2]);
    ylim([-2 2]);
end