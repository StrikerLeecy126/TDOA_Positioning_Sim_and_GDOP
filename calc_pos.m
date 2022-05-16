function[Z_LS,Z,Z_ML,Zp]=calc_pos(r_i1,SNR,r)
    % Anchor Nodes Position
    ANode1=[3150 3150];
    ANode2=[6300 0];
    ANode3=[6300 6300];
    ANode4=[0 6300];
    ANode5=[0 0];
    
    % Calculate ki
    k1=ANode1(1)^2+ANode1(2)^2;
    k2=ANode2(1)^2+ANode2(2)^2;
    k3=ANode3(1)^2+ANode3(2)^2;
    k4=ANode4(1)^2+ANode4(2)^2;
    k5=ANode5(1)^2+ANode5(2)^2;
    
    % Calculate G and Y Matrix
    G=2.*[ANode2(1)-ANode1(1),ANode2(2)-ANode1(2),r_i1(1);
          ANode3(1)-ANode1(1),ANode3(2)-ANode1(2),r_i1(2);
          ANode4(1)-ANode1(1),ANode4(2)-ANode1(2),r_i1(3);
          ANode5(1)-ANode1(1),ANode5(2)-ANode1(2),r_i1(4)];
    Y=[k2-k1-r_i1(1)^2;k3-k1-r_i1(2)^2;k4-k1-r_i1(3)^2;k5-k1-r_i1(4)^2];
    
    Z_LS=(G'*G)\G'*Y;                                               % LS Result of Position
    
    % 2 Step ML
    SNR_L=10^(SNR/10);                                              % Linearize SNR

    cove=4./SNR_L.*...
        [2*r(1).*r(1), r(1).*r(2), r(1).*r(3), r(1).*r(4);
        r(2).*r(1), 2*r(2).*r(2), r(2).*r(3), r(2).*r(4);
        r(3).*r(1), r(3).*r(2), 2.*r(3)*r(3), r(3).*r(4);
        r(4).*r(1), r(4).*r(2), r(4).*r(3), 2*r(4).*r(4)];          % Error Covariance Matrix
    Z=(G'/cove*G)\G'/cove*Y;                                        % 1 Step Result Z
    covZ=inv(G'*inv(cove)*G);                                       % Z Covariance Matirx
    D=diag([Z(1)-ANode1(1),Z(2)-ANode1(2),Z(3)]);                   % D Matrix
    cove1=4*D*covZ*D;                                               % 2 Step Error Covariance Matrix cove1
    
    G1=[1 0;0 1;1 1];                                               % G1 Matrix
    Y1=[(Z(1)-ANode1(1))^2;(Z(2)-ANode1(2))^2;Z(3)^2];              % Y1 Matrix
    Z_ML=(G1'/cove1*G1)\G1'/cove1*Y1;                               % 2 Step ML Estimation Result
    
    Zp=sqrt(Z_ML);                                                  % Extract Position from Result
    Zp=[sign(Z(1)-ANode1(1)).*Zp(1);sign(Z(2)-ANode1(2)).*Zp(2)]+ANode1';
end


