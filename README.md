# Chan's Method of TDOA Positioning Simulation and GDOP Calculation
MATLAB Simulation of Calculating TDOA using Chan's Method and Calculating GDOP

Note: This is one of the course projects of Wireless Sensor Network in UESTC.  
These codes are used for idea formation and guidance and are definitely not perfect.  
Therefore please do not just only copy and paste, it could affect your final result of the course.

## Recommended References
A Simple and Efficient Estimator for Hyperbolic Location - Y. T. Chan, K. C. Ho  
Hyperbolic Positioning Accuracy Issues Measurement Noise, Geometric Dilution of Position, and Synchronization Errors - Marc A. Weiss, Charles Barry  

## Code Note
Generate_tdoa_base_band_signal.m: Given by Lecturer, generate signal with AWGN noise.  
calc_delay.m: Calculate actual delays.  
calc_delayes.m: Estimate delays with awgn using matched filter.  
calc_gdop.m: Calculate GDOP. 
calc_pos.m: Calculate estimated position.  
main.m: Code frame, calculate RMSE.  

## Formulae Derivation
![image](https://user-images.githubusercontent.com/76428637/168616917-181d6b38-8aa0-4fa9-8a33-f0f9946d58d7.png)
![image](https://user-images.githubusercontent.com/76428637/168619029-34a01229-5475-4440-a5c7-3cf118e59d59.png)
![image](https://user-images.githubusercontent.com/76428637/168616998-53ff4ddb-932b-4852-9f55-694aa4d76e60.png)

## GDOP Contour Line and RMSE
![image](https://user-images.githubusercontent.com/76428637/168617352-dd67a634-ef1a-4e8b-a7a5-456c83d050bf.png)
![image](https://user-images.githubusercontent.com/76428637/168617439-c0ed697b-691d-4946-8436-3a1e8d974b20.png)

