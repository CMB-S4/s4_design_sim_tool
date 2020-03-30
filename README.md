# CMB-S4 design simulation tool
> Generate CMB-S4 simulated maps of foregrounds/atmosphere and noise based on the configuration of the experiment


[![PyPI badge](https://img.shields.io/pypi/v/s4_design_sim_tool)](https://pypi.org/project/s4-design-sim-tool)

`s4_design_sim_tool` is a library, a command-line tool and a web interface to properly combine and weight pre-executed maps from time-domain and map-domain simulation based on input parameters and the instrument configuration (e.g. location of telescopes, distribution in frequency of the tubes).

The software is available in the [CMB-S4/s4_design_sim_tool](https://github.com/CMB-S4/s4_design_sim_tool) repository on Github, and can be installed locally with PyPI, it currently needs to run at NERSC to access the input maps:

    pip install s4_design_sim_tool

the web interface is temporarily available at: 

* <http://132-249-238-90.compute.cloud.sdsc.edu/>

## Configuration options

The simulation configuration is defined by a TOML text file,
see for example the TOML configuration for the CMB-S4 reference design: [s4_reference_design.toml](https://github.com/CMB-S4/s4_design_sim_tool/blob/master/s4_reference_design.toml)

### Sky emission

The first section of the configuration files defines which input components should be considered,
it is possible to choose a weight between 0 and 1 for all components, for example we can simulate residual foregrounds after cleaning or partial de-lensing, and we can choose the tensor-to-scalar ratio `r`.

Input maps are already top-hat bandpass integrated, beam-smoothed, and ran through a filter-and-bin mapmaking algorithm in time-domain, they are combined based on the configuration file and are not influenced by the experiment configuration.
For more details, see the [input maps section below](#Input-maps) and the [Jupyter notebook with the implementation](/s4_design_sim_tool/foregrounds).

### Experiment

The second section defines the design of the instrument, it is possible to customize the number and location of SAT and LAT telescope and for each of them modify what tube are mounting, keeping the constraint of 3 tubes for SAT and 19 for LAT.

Scaling of atmospheric and instrument noise is performed with these assumption:

* scale the 10-day simulations to 1 year considering the observing efficiency
* for Pole also consider the additional efficiency factor
* scale by the detector-years for noise and telescope-years for atmosphere

Therefore 2 tubes on the same telescope have the same atmospheric noise of 1 tube, to reduce noise from the atmosphere we need to distribute tubes across multiple telescopes.
For instrument noise instead, it doesn't matter their distribution across telescopes, just their number.

For more details, see the [input maps section below](#Noise-maps) and the Jupyter notebooks with the implementation for the [atmosphere](/s4_design_sim_tool/atmosphere) and [noise](/s4_design_sim_tool/noise).

#### Splits

The tool supports loading up to 8 splits, which are suitable to simulate 1 full mission map and 7 yearly maps (or 7 interleaved splits).
In this case, the tool will generate first a full mission map and then the number of splits requested, loading different realizations of atmosphere and noise and weighting them properly.

## Input maps

### Sky signal

* Full-sky Nside 4096 (LAT) and Nside 512 (SAT)
* Galactic, extragalactic and CMB
* Bandpass integrated with tophat bandpasses from `s4sim`
* Smoothed with gaussian beams

See the [202002_foregrounds_extragalactic_cmb_tophat](https://github.com/CMB-S4/s4mapbasedsims/tree/master/202002_foregrounds_extragalactic_cmb_tophat) map based simulations.

Then the maps were used as inputs for a time-domain simulation with TOAST to simulate the effect
of a filter-and-bin mapmaking with the CMB-S4 scanning strategy both for Pole and Chile.

### Noise maps

Noise was simulated for one tube in each telescope.  We observed according to a 10-day schedule without Sun or Moon avoidance. For Chile, the schedules already emulate the maximum observing efficiency.  For simplicity, the Pole schedules only    include one full scan of the respective patch per day.  As a result, the Pole observing efficiencies are 46.29% (SAT) and 37.23% (LAT). These efficiencies must be accounted for by downweighting the Pole noise and atmospheric maps with their      scheduled efficiences.

These factors should be corrected for the *noise and atmosphere* maps: `map_out = map_in * sqrt(efficiency)`.

Also for expedience, we downsampled the densest focal planes to reduce the overall detector counts:
```
telescope  band   thinfp
LAT        HFL      8
LAT        MFL      8
LAT        LFL      1
LAT        ULFL     1
SAT        HFS      8
SAT        MFHS     4
SAT        MFLS     4
SAT        LFS      1
```
These factors should be corrected for in the *noise* maps but not in the atmospheric maps: `map_out = map_in / sqrt(thinfp)`. 
