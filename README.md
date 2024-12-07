# LQT3-SGLT2i 
Code and data for cardiac sodium channel and ventricular myocyte simulations published in [Lunsonga et al. JMCC. (2024)](https://www.sciencedirect.com/science/article/pii/S0022282824002049?dgcid=author#s0095)

## Overview
The Matlab code in this package underlies all simulations presented in Lunsonga *et al.* Also included are select experimental data from the study that are used for fitting and validating the models.

Additional code for the optimizations used in model construction is available upon request. Please contact Andy Edwards: [andy@simula.no] for any such requests, or other queries.

## Installation and Usage
The package was built with Matlab Release 2023b and runs as a standalone structure if you have an existing Matlab installation. Install as a direct download or clone the repository:
`git clone https://github.com/andygedwards/LQT3-SGLT2i.git`

Once installed, the simulations underlying published Figures 6 and 7 are reproduced by running files run_V_clamp_SGLT2i.m and run_TorORd_SGLT2i.m, respectively. Additional plotting for each set of simulations is implemented in plot_TorORd_SGLT2i.m and plot_V_clamp_SGLT2i.m.

## License
We provide this code under Creative Commons [BY-SA license](https://creativecommons.org/licenses/by-sa/4.0/) conditions.

## Support
This development was supported by the [Computational Physiology Department](https://www.simula.no/research/research-departments/computational-physiology) at [Simula Research Laboratory](https://www.simula.no). Please find our related packages and projects at [Github](https://computationalphysiology.github.io/). 

