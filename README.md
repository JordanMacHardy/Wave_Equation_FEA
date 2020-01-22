# Wave_Equation_FEA
Solves The Wave Equation For Specified Boundary Conditions.
See "derivation" PDF for equations and derivation.
See interpretation of results for my musings.

The user input parameter theta should be from 0-1, which blend between using an explicit or implicit numerical method for solving. A theta of .5 uses the Crank Nicholson method.

included files:

-main.m
- mesh and boundary condition data: 
    - dsg-conectivity.dat
    - dsg-coordinates.dat
    - dsg-dirichelet.dat
    - dsg-neumann.dat
    - derivation.pdf
    - interpretation.pdf
