# Wave_Equation_FEA
This program solves the Wave Equation for light entering a perfectly reflective box through two slits. 

A detailed derivation of relevant equations can be seen at:
https://drive.google.com/open?id=1rnEwv8iyx85anut9yDHim-nFCf3CNscU

My interpretation of the results can be seen at: 
https://drive.google.com/open?id=1T4KembuL3xmAfoVbkX4FSn23zG-WQHx3

The user input parameter theta blends between using an explicit or implicit numerical method for solving. Theta should be from 0-1. 
Theta = 0 fully explicit
Theta = 1 fully implicit 
Theta = 0.5 Crank Nicholson method.

included files:

- main.m
- mesh and boundary condition data: 
    - dsg-conectivity.dat
    - dsg-coordinates.dat
    - dsg-dirichelet.dat
    - dsg-neumann.dat
- Functions
    - g.m
    - gdotdot.m
    - klocal.m
    - mlocal.m

