# Wave_Equation_FEA
This program solves the Wave Equation for light entering a perfectly reflective box through two slits. 

A detailed derivation of relevant equations can be seen at:
https://drive.google.com/open?id=1rnEwv8iyx85anut9yDHim-nFCf3CNscU

My interpretation of the results can be seen at: 
https://drive.google.com/open?id=1T4KembuL3xmAfoVbkX4FSn23zG-WQHx3

The user input parameter theta should be from 0-1, which blend between using an explicit or implicit numerical method for solving. A theta of .5 uses the Crank Nicholson method.

included files:

-main.m
- mesh and boundary condition data: 
    - dsg-conectivity.dat
    - dsg-coordinates.dat
    - dsg-dirichelet.dat
    - dsg-neumann.dat

