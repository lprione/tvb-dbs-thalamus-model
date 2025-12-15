# Multiscale DBS Model – ANT Thalamus (MSc thesis code)

This repository is the research-code companion to the MSc thesis:

**“A multiscale computational model of Deep Brain Stimulation of the Anterior Nucleus of the Thalamus for epilepsy treatment”**  
Author: Lorenzo Prione (University of Genoa, University of Twente)

## What this repo is (and is not)

- **What it is:** the code, notebooks, and analysis scripts used during the thesis work (TVB simulations + DBS stimulation pattern + analysis/visualization).
- **What it is not:** a polished, one-command package. The original workflow was executed in a TVB-enabled Python environment (often via Jupyter), with large inputs stored locally.

The goal of keeping this public is **reviewability**: you can see how the model and analysis were implemented, even if you do not have the full dataset/layout used during development.

## Repository layout

- `tvb_dbs/`  
  Core Python scripts used to configure and run TVB simulations and to compute summary statistics.
- `notebooks/`  
  Lightweight notebooks (outputs cleared) used for exploration and sensitivity analysis.
- `data/`  
  **Not included** large inputs (connectivity/projection/region mapping) are documented in `data/README.md`.
- `figures/`  
  Exported figures used in the thesis.

## Data & external inputs

To run the full simulation pipeline you will need a small set of files referenced by the scripts:

- `DBS007_connectivity_374.zip` (TVB connectivity/weights; in my workflow this was a TVB-compatible connectivity archive)
- `scaled_projection_matrix_65_360.npy` (projection matrix)
- `region_mapping_374.txt` (region mapping)

See **`data/README.md`** for the expected locations and formats, and notes on using a **standard TVB connectivity** versus a custom one.

## How it was run (original workflow)

The typical workflow during the thesis was:

1. Prepare input files in `data/` (connectivity, projection matrix, region mapping).
2. Run simulations from Python/Jupyter using the scripts in `tvb_dbs/`.
3. Post-process and visualize results (Python and/or MATLAB FieldTrip scripts).

If you want a starting point for reading the code, begin with:

- `tvb_dbs/dbs_func.py` (DBS temporal stimulation function)
- `tvb_dbs/config_sim.py` and `tvb_dbs/run_simulation.py` (simulation configuration and execution)
- `tvb_dbs/simulation_wrapper.py` (wrapper used by analysis/sensitivity scripts)

## Notes on notebooks

Notebooks are kept **without stored output** (to avoid huge diffs and repo bloat). Figures and results should be exported to `figures/` and/or saved as files when needed.

## License

MIT License – see `LICENSE`.
