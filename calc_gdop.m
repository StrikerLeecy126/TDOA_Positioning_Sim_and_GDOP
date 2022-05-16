function GDOP=calc_gdop(Zp)
    % Extract Postiion x0 and y0
    x0=Zp(1);
    y0=Zp(2);
    
    % Anchor Nodes Position
    ANode1=[3150 3150];
    ANode2=[6300 0];
    ANode3=[6300 6300];
    ANode4=[0 6300];
    ANode5=[0 0];
    
    % Calculate H Matrix
    r1=sqrt((x0-ANode1(1))^2+(y0-ANode1(2))^2);
    r2=sqrt((x0-ANode2(1))^2+(y0-ANode2(2))^2);
    r3=sqrt((x0-ANode3(1))^2+(y0-ANode3(2))^2);
    r4=sqrt((x0-ANode4(1))^2+(y0-ANode4(2))^2);
    r5=sqrt((x0-ANode5(1))^2+(y0-ANode5(2))^2);
    
    C1=(x0-ANode1(1))/r1;
    C2=(x0-ANode2(1))/r2;
    C3=(x0-ANode3(1))/r3;
    C4=(x0-ANode4(1))/r4;
    C5=(x0-ANode5(1))/r5;
    
    D1=(y0-ANode1(2))/r1;
    D2=(y0-ANode2(2))/r2;
    D3=(y0-ANode3(2))/r3;
    D4=(y0-ANode4(2))/r4;
    D5=(y0-ANode5(2))/r5;
    
    H=[C2-C1, C3-C1, C4-C1, C5-C1;
       D2-D1, D3-D1, D4-D1, D5-D1];
    
    % Calculate GDOP
    GDOP=sqrt(trace(pinv(H*H')));
end
