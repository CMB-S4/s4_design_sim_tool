# CMB-S4 Reference Simulation tool

## Configuration options

see [`s4_reference_design.toml`](s4_reference_design.toml)

## Input maps

### Unfiltered sky signal

* Full-sky Nside 4096 (LAT) and Nside 512 (SAT)
* Galactic, extragalactic and CMB
* Bandpass integrated with tophat bandpasses from `s4sim`
* Smoothed with gaussian beams

See the [`202002_foregrounds_extragalactic_cmb_tophat`](https://github.com/CMB-S4/s4mapbasedsims/tree/master/202002_foregrounds_extragalactic_cmb_tophat) map based simulations

### Noise maps

Noise was simulated for one tube in each telescope.  We observed according to a 10-day schedule without Sun or Moon avoidance. For Chile, the schedules already emulate the maximum observing efficiency.  For simplicity, the Pole schedules only include one full scan of the respective patch per day.  As a result, the Pole observing efficiencies are 46.29% (SAT) and 37.23% (LAT). These efficiencies must be accounted for by downweighting the Pole noise and atmospheric maps with their scheduled efficiences.

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
