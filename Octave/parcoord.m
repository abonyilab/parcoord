% parcoord - draws a figure of parallel coordinates
% [tau, intersections] = parcoord(coord, axplaces, index, axnames) draws a
% figure `coord' on the axes, which are placed in 'axplaces' positions, sorted in `index' order. All  
%'coord' matrix of coordinates to be visualized on 'axplaces' axplaces vector which are placed in
%a given order 'index'. The axes are named 'axnames'. Returns the rank
%correlation and intersections between the variables (arranged in index order)
function [tau, intersections] = parcoord(coord, axplaces, index, axnames)

[N,n]=size(coord);
gld = find(index == 1);
pc=prctile(coord(:,gld),fliplr([10 25 50 75 100]));

clf
hold on
labels=['y-','m-','b-','g','r'];
types = ['Q4'; 'Q3'; 'Q2'; 'Q1'; 'D1'];
handles = [];
for i=1:length(pc)
    ind=find(coord(:,gld)<pc(i));
    h = plot(axplaces, coord(ind,:), labels(i));
    handles = [handles h(1,1)];
    
end
legend(handles,types, 'location','best', 'AutoUpdate','off')
for i=1:length(pc)
    ind=find(coord(:,gld)<pc(i));
    plot(axplaces, coord(ind,:), labels(i));
end

for i=1:length(index)
    %Draw the axplaces
    line([axplaces(index(i)), axplaces(index(i))],[0 N], 'Color','black','LineStyle',':', 'LineWidth', 2.5);
    an = text(axplaces(index(i)), N, axnames(index(i)),'Color','black', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize',12);
    set(an,'Rotation',-90);
end
line([axplaces(gld), axplaces(gld)],[0 N], 'Color','red','LineStyle',':', 'LineWidth', 2.5);

ylabel("Ranks");
xlabel("");
set(gca,'FontSize',16)



%% Metrics: rank correlation and intersections
ylim([0 N+50]);
set(gca, 'YDir','reverse')

tau = [];
intersections = [];
for j =2:n
    tau = [tau kendall(coord(:, j-1), coord(:, j))];
    intersections = [intersections, ((1-tau(j-1)))*(N*(N-1))/4]; 
end

intersections(isnan(intersections)) = 0;

end