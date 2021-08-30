%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Heterogeneous Recurrence Plot                        %
% ----------------------------------------------------------------------- %
% - Input:                                                                %
%         - s: a categorical sequence                                     %
%         - k: the size of the state cardinality                          %
%         - plt: defalut=0; option to plot the figure                     %
% - Output:                                                               %
%         - Cx: the corresponding x coordinate of Rij = k                 %
%         - Cy: the corresponding y coordinate of Rij = k                 %
%         - Col: the corresponding state k of Rij = k                     %
% -- Author: Cheng-Bang Chen (cbchen@chengbangchen.me)                    %
%            08/20/2021                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Cx, Cy, Col]=HRP(s,k,plt)
    if nargin < 3
        plt = 0;
        if nargin < 2
            k = max(s);
        end
    end

    Cx = [];
    Cy = [];
    Col = [];
    L = length(s);
    M = zeros(L,L);
    for i = 1:k
        tmp_idx = find(s==i);
        if(length(tmp_idx)>0)
            [X, Y] = meshgrid(tmp_idx, tmp_idx);
            Cx = [Cx;X(:)];
            Cy = [Cy;Y(:)];
            Col = [Col;i*ones(length(X(:)),1)];
        end
    end
    if plt >0
        f1 = figure;
        scatter(Cx, Cy, 0.5, Col, '.');
        title('Heterogeneous Recurrence Plot');
        xlabel('State Index');
        ylabel('State Index');
        xlim([1 L]);
        ylim([1 L]);
        colormap(jet(k));
        box on
    end
end