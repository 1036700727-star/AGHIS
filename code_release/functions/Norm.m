function [data] = Norm(data)
[n,m] = size(data);
% % normolize
% if n== 2310 |800 |6598  %segment(2310),vehicle3,musk,kr-vs-k-zero_vs_eight,a8a
%     for i = 1:n
%         data(i,:) = (1/norm(data(i,:))).*data(i,:);%not vowel0
%          
%         data = zscore(data); %twitter
%     end
% elseif n == 22696 |1460| 1243
% %     for i = 1:n
% %     %z=norm(data(i,:));
% %     %data(i,:) = (1/norm(data(i,:))).*data(i,:);
% %     z = sqrt(sum(data(i,:).^2, 2));
% %     data(i,:) = data(i,:) ./ sqrt(sum(data(i,:).^2, 2));
% %     end   
%     data = zscore(data);
% else
%     data = data;
% end

% if n==1243 %svmguide3
%     data = zscore(data);
% end

if n == 2310 || n == 1460    % segment(2310),  musk, kr-vs-k-zero_vs-eigth, a8a
    for i = 1:n
        data(i,:) = (1/norm(data(i,:))) .* data(i,:); % not vowel0
    end
    data = zscore(data); 
elseif n == 22696  || n == 1243 || n == 800 || n == 6598  %svmguide3，vehicle3,
    data = zscore(data); 
else
    % No normalization is performed
    data = data; 
end