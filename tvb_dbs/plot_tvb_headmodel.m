% plot_tvb_headmodel.m
% Visualization of headmodel from TVB dataset - Lorenzo Prione

% Upload cortical surfaces
cortex_vertices = load('cortex/vertices.txt');
cortex_triangles = load('cortex/triangles.txt') + 1; % 1-based indexing

scalp_vertices = load('face/vertices.txt');
scalp_triangles = load('face/triangles.txt') + 1;

% Read cortex centers
fid = fopen('centers.txt', 'r');
if fid == -1
    error('File centers.txt non trovato.');
end
data = textscan(fid, '%s %f %f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true);
fclose(fid);
nodes = [data{2}, data{3}, data{4}]; % Coordinate XYZ

% Definition of highlighted nodes (specific case of amygdala)
normal_nodes = [1:360, 362:367, 369:size(nodes,1)];
highlight_nodes = [361, 368];

% Plot 3D
figure('Color', 'w', 'Position', [100, 100, 600, 600]); hold on;

% Scalp surface
trisurf(scalp_triangles, scalp_vertices(:,1), scalp_vertices(:,2), scalp_vertices(:,3), ...
    'FaceColor', [1, 0.8, 0.6], 'FaceAlpha', 0.15, 'EdgeColor', 'none');

% Cortex surface
trisurf(cortex_triangles, cortex_vertices(:,1), cortex_vertices(:,2), cortex_vertices(:,3), ...
    'FaceColor', [0.7, 0.7, 0.7], 'FaceAlpha', 0.15, 'EdgeColor', 'none');

% Cortex nodes
scatter3(nodes(normal_nodes,1), nodes(normal_nodes,2), nodes(normal_nodes,3), ...
    30, [0, 1, 0.3], 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1);
scatter3(nodes(highlight_nodes,1), nodes(highlight_nodes,2), nodes(highlight_nodes,3), ...
    100, [1, 0.3, 0.3], 'filled', 'MarkerEdgeColor', 'k', 'LineWidth', 1);

% Graphical settings
axis equal; axis off;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Final TVB Head Model', 'FontSize', 14, 'FontWeight', 'bold');
view([120, 35]);
camlight('headlight'); camlight('right'); lighting gouraud;

hold off;

% Optional saving
% saveas(gcf, 'tvb_headmodel.png')