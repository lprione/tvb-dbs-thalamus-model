# Data folder

This repository intentionally does **not** ship large binary inputs used during the thesis.
Place required inputs here to run the full TVB simulation workflow.

## Required inputs (referenced by the Python scripts)

Create the following files (or symlinks) under `data/`:

- `data/DBS007_connectivity_374.zip`  
  TVB-compatible connectivity archive (weights/tract lengths/region labels).  
  **Option A (recommended for a public/repro-friendly setup):** use a *standard TVB connectivity* (from the TVB datasets) and rename or adjust paths accordingly.  
  **Option B:** use the exact connectivity used in the thesis (if you are allowed to share it).

- `data/scaled_projection_matrix_65_360.npy`  
  Numpy array used to map simulated regional activity to EEG sensors (projection matrix).

- `data/region_mapping_374.txt`  
  Text mapping between the connectivity parcellation and the regions used by the model/analysis.

> If you share these files privately (e.g., in a separate `dataset.zip` or institutional storage), keep them out of the public repo and document how to obtain them.

## Optional / generated outputs

Depending on your workflow, you may generate (and typically **do not** commit) files such as:

- simulated EEG arrays (`*.npy`)
- intermediate summaries/statistics
- exported figures

Add them to `.gitignore` or store them outside the repo.

## Suggested structure (if you prefer subfolders)

Instead of flat files in `data/`, you can also use:

- `data/connectivity/DBS007_connectivity_374.zip`
- `data/projection/scaled_projection_matrix_65_360.npy`
- `data/mapping/region_mapping_374.txt`

If you do this, keep paths consistent with the existing scripts (or use symlinks), since the code is preserved as-is.
