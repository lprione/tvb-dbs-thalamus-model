# TVB DBS Model – Code guide

This folder contains the core Python/MATLAB scripts used in the MSc thesis workflow.

## Quick navigation

If you want to understand the project quickly, start here:

- `dbs_func.py`  
  Custom DBS temporal stimulation function (used as a TVB stimulus/time-series driver).
- `config_sim.py`  
  Simulation configuration (model parameters, stimulation settings, runtime configuration).
- `run_simulation.py`  
  Entry-point script used to launch a simulation run in the thesis workflow.
- `simulation_wrapper.py`  
  Wrapper used by analysis/sensitivity scripts to run simulations and return outputs in a consistent format.
- `calculate_summary_statistics.py`  
  Post-processing utilities used to compute summary metrics from simulated data.
- `Sensitivity Analysis.py`  
  Python sensitivity analysis logic (paired with the notebooks in `../notebooks/`).

## MATLAB / FieldTrip analysis

- `analyze_simulated_eeg.m`  
  MATLAB analysis script used to post-process simulated EEG (FieldTrip-based workflows).

> The FieldTrip toolbox is not included. This repo only contains the thesis-side scripts.

## Data dependencies

The Python scripts reference a small set of external inputs (connectivity, projection matrix, region mapping).
See `../data/README.md` for the exact filenames and where to place them.

## Running expectations

This code was developed and executed in a TVB-enabled Python environment (often via Jupyter).
It may require additional setup (TVB installation + datasets) and access to the external input files.
The code is kept **unchanged** here; the README focuses on helping reviewers navigate and understand it.
