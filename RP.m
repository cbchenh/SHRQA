%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    epsilon - Recurrence Plot                            %
% ----------------------------------------------------------------------- %
% - Input:                                                                %
%         - X: a sequence of data                                         %
%         - epsilon: the threshold level to consider a recurrence         %
%         - plot_opt: defalut=0; plot the RP                              %
% - Output:                                                               %
%         - R: the recurrence matrix                                      %
%         - x: the corresponding x coordinate of Rij = 1                  %
%         - y: the corresponding y coordinate of Rij = 1                  %
% -- Author: Cheng-Bang Chen (cbchen@chengbangchen.me)                    %
%            08/20/2021                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,x,y] = RP(X, epsilon, plot_opt)
    if nargin < 3
        plot_opt = 0;
    end
    N = length(X);
    D = squareform(pdist(X));
    [x, y] = meshgrid(1:N,1:N);
    R = D < epsilon;
    x = x(find(R==1));
    y = y(find(R==1));
    if plot_opt == 1
        figure();
        box on;
        ax=gca;
        ax.LineWidth=5;
        set(gcf,'Color',[1 1 1]);
        plot(x, y, '.');
        title('Recurrence Plot');
        xlabel('State Index');
        ylabel('State Index');
        xlim([0,N]);
        ylim([0,N]);
    end
end