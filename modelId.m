%
function p=modelId(ytrain,trainLabels,order,norm_used)

if nargin == 2
    norm_used=inf;
    order=3;
elseif nargin == 3
    norm_used = inf;
end

p=zeros(order,numel(unique(trainLabels)));

%% seperate data due to dynamic switch


for i=1:max(trainLabels)
    for epsilon=1.2:0.1:3
        % epsilon=7;
        fprintf('order=%d\n',order);
        [p_est group]=indep_dyn_switch_detect(mean(ytrain(:,trainLabels==i),2),norm_used,epsilon,order);
        %      [x group]=indep_dyn_switch_detect1(data(16662:16662+1000,2),norm_used,epsilon,order);
        %     [x group] = indep_dyn_switch_detect_offset(ymean(1:532,1),norm_used,epsilon,order);
        %     group = multidim_dyn_switch_detect(yh,norm_used,epsilon,order);
        
        if ~isempty(group)
            fprintf('The number of groups=%d\n',numel(unique(group)));
            if numel(unique(group))>1
                continue;
            else
                fprintf('class %d model acquired successfully\n',i);
                p(:,i)=p_est(1:3);
                break;
            end
        end
    end
    if numel(unique(group))>1
        error('no feasible model for class %d, try increasing epsilon. \n',i);
    end
    close all;
end


end