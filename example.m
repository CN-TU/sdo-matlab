
load exampledata.mat
fprintf("SDO, twodimensional example \n");
figure(1)
scatter(dataPoints(:,1),dataPoints(:,2),5,label);
title('Datapoint color based on: class (1, 2, 3 or 4) and outliers')
fprintf("Calling SDO with default parameters...");
[ y, observers, param ] = sdof( dataPoints );
figure(2)
scatter(dataPoints(:,1),dataPoints(:,2),5,y);
title('Datapoint color based SDO outlierness rank');
colorbar
