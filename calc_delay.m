function [t1,t2,t3,t4,t5]=calc_delay
c=3e8;                  % Light Speed
step=200;               % Actual Position Sampling Step
x=100:step:6200;        % x position
y=100:step:6200;        % y position

% Anchor Nodes Position
ANode5=[0 0];
ANode2=[6300 0];
ANode3=[6300 6300];
ANode4=[0 6300];
ANode1=[3150 3150];

% Calculate Actual Delays To Each Anchor Node
a=1;
for i=1:length(x)
    for j=1:length(y)
        t1(i,j)=sqrt((x(i)-ANode1(1))^2+(y(j)-ANode1(2))^2)/c;
        t2(i,j)=sqrt((x(i)-ANode2(1))^2+(y(j)-ANode2(2))^2)/c;
        t3(i,j)=sqrt((x(i)-ANode3(1))^2+(y(j)-ANode3(2))^2)/c;
        t4(i,j)=sqrt((x(i)-ANode4(1))^2+(y(j)-ANode4(2))^2)/c;
        t5(i,j)=sqrt((x(i)-ANode5(1))^2+(y(j)-ANode5(2))^2)/c;
        a=a+1;
    end
end



