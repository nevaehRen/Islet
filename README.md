# Pancreatic Islet Fast-Slow Mixed Oscillation Mathematical Model

This repository contains the mathematical modeling code for pancreatic islet oscillations, corresponding to the findings in our research paper:  
**Pancreatic Islet Oscillation Rhythmicity Arises from δ and α Cell Interactions**  

## Key Experimental & Modeling Findings
### Experimental Phenomenon
Continuous adjustment of δ-α cell coupling strength drives a transition of fast-oscillating islets to mixed, then slow oscillations.  

### Model Simulation
Mathematical modeling confirms this fast → mixed → slow oscillation transition is governed by a **Hopf bifurcation**.  

## Code Contents
This repository includes the nullcline analysis code featured in **Figure 6e** and **Figure 6g** of the paper:
- **Figure 6e**: Simulates continuous variation of α-cell mass (`Params.alphaMass`), reproducing the fast-mixed-slow transition via Hopf bifurcation.
- **Figure 6g**: Simulates continuous variation of exogenous somatostatin concentration (`Params.s_ex`), also capturing the fast-mixed-slow transition via Hopf bifurcation.
