Release 1.1.2
=============

* Released on 22 April 2021
* Updated the South Pole input atmosphere maps to reduce them by a factor of 2 following a comparison with BK15 data
* Used to rerun atmosphere and noise for <https://github.com/CMB-S4/s4mapbasedsims/tree/master/202102_design_tool_run>
* Update LAT sensitivity factors to include loss due to uneven NET across detectors <https://github.com/CMB-S4/s4_design_sim_tool/commit/2f9d3d14a8ca29ded49>

Release 1.1.1
=============

* Released on 13 April 2021
* Used to rerun atmosphere and noise for <https://github.com/CMB-S4/s4mapbasedsims/tree/master/202102_design_tool_run>
* Scale atmosphere polarization by thinning factor <https://github.com/CMB-S4/s4_design_sim_tool/pull/24>
* Sensitivity factors <https://github.com/CMB-S4/s4_design_sim_tool/pull/23>

Release 1.1.0
=============

* Released on 16 March 2021
* Used for the first version of the Winter 2021 run <https://github.com/CMB-S4/s4_design_sim_tool/pull/22>
* Updated all the input time domain simulation maps <https://github.com/CMB-S4/s4_design_sim_tool/pull/22>
* Moved instrument model to astropy tables <https://github.com/CMB-S4/s4_design_sim_tool/commit/aa132bb46049124c>
* Fixed bug in handling of CMB Tensor component <https://github.com/CMB-S4/s4_design_sim_tool/commit/596c20233b125858f>
* Observing efficiency by band <https://github.com/CMB-S4/s4_design_sim_tool/pull/20>
* Fix hitmaps and wcov for splits <https://github.com/CMB-S4/s4_design_sim_tool/commit/39cb65f6fa4d1e70>
* Support multiple TOML configuration files <https://github.com/CMB-S4/s4_design_sim_tool/pull/19>

Release 1.0.4
=============

* Released on July 1st, 2020
* Support for processing Covariance matrices and hitmaps
* Used to generate Covariance matrices and hitmaps for [`202006_reference_design`](https://github.com/CMB-S4/s4mapbasedsims/tree/master/202006_reference_design)

Release 1.0.3
=============

* Released on June 16th, 2020
* Used [`202006_reference_design`](https://github.com/CMB-S4/s4mapbasedsims/tree/master/202006_reference_design)
