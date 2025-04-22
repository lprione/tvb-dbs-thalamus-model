# TVB DBS Model – Source Code Overview

This repository contains core scripts for analyzing and visualizing simulation results from the TVB-based DBS thalamic model. It includes both EEG analysis tools and 3D brain model visualization.

---

## 📖 Table of Contents

- [🧪 EEG Analysis (FieldTrip)](#-eeg-analysis-fieldtrip)
  - [📋 Features](#-features)
  - [🛠 Requirements](#-requirements)
  - [💡 Notes](#-notes)
- [🧠 TVB Head Model Visualization](#-tvb-head-model-visualization)
  - [📋 Features](#-features-1)
  - [📁 Required Input Files](#-required-input-files)
  - [🖼 Output](#-output)
  - [🔧 How to Use](#-how-to-use)
  - [📌 Notes](#-notes-1)
- [⚡ DBS_func – Custom Temporal Stimulation for TVB](#-dbs_func--custom-temporal-stimulation-for-tvb)
  - [🧠 Overview](#-overview)
  - [🚀 Example Usage](#-example-usage)
  - [🧪 Applications](#-applications)
  - [📌 Notes](#-notes-2)

---

## 🧪 **EEG Analysis (FieldTrip)**

`analyze_simulated_eeg.m` provides an end-to-end pipeline for analyzing simulated EEG signals derived from DBS models, using the [FieldTrip](https://www.fieldtriptoolbox.org/) toolbox.

### 📋 **Features**

- **Artifact rejection** based on thresholding and statistical methods  
- **Epoching** of data around DBS stimulation events  
- **ERP (Event-Related Potentials)** and **GMFP (Global Mean Field Power)** computation  
- **Topographical plotting** of neural activity across electrodes and time  

### 🛠 **Requirements**

- MATLAB  
- [FieldTrip Toolbox](https://www.fieldtriptoolbox.org/)  
- EEG simulation output from your TVB/DBS model  

### 💡 **Notes**

> A similar analysis was performed on real EEG data using a private version of the pipeline adapted from `analyze_simulated_eeg.m`. Due to ownership and collaboration considerations, that code is not publicly available.

---

## 🧠 **TVB Head Model Visualization**

`plot_tvb_headmodel.m` provides a 3D visualization of a head model based on structural data from *The Virtual Brain* (TVB). It is mainly used to validate and illustrate brain region positioning and mesh structure.

### 📋 **Features**

- Loads surface meshes of cortex and scalp  
- Plots regional centers derived from a 76-node connectivity matrix  
- Highlights custom-defined regions (e.g., amygdala)  
- Supports figure export for documentation or presentations  

### 📁 **Required Input Files**

- `cortex/vertices.txt`, `cortex/triangles.txt`  
- `face/vertices.txt`, `face/triangles.txt`  
- `centers.txt` — XYZ coordinates of TVB-defined brain regions  

> These files were exported using the TVB GUI with a connectivity setup of **76 brain regions**.

### 🖼 **Output**

- A 3D figure of the head model with mesh surfaces and highlighted region centers  
- Optional export to `tvb_headmodel.png`

### 🔧 **How to Use**

Open the script in MATLAB and run:

```matlab
plot_tvb_headmodel
```

Ensure input files are located in their expected folders.

### 📌 **Notes**

- The script is modular and can be adapted to different models or region selections.  
- Plotting styles and node highlights can be customized for specific analyses.

---

## ⚡ **DBS_func – Custom Temporal Stimulation for TVB**

`dbs_func.py` is a fully custom stimulation pattern class designed to work with The Virtual Brain (TVB) simulator. It models a biphasic pulse train followed by an exponential decay, providing a biologically inspired stimulation pattern for Deep Brain Stimulation (DBS) modeling studies.

### 🧠 **Overview**

The function extends TVB’s `TemporalApplicableEquation` interface and can be used as a temporal input for `StimuliRegion` objects in simulations. It supports configuration of pulse width, repetition frequency, onset time, and an optional exponential decay component.

### 🚀 **Example Usage**

```python
from src.dbs_func import DBS_func
import tvb.simulator.lab as tsl
import numpy as np

# Instantiate DBS temporal function
eqn_t = DBS_func()

# Create stimulation pattern
stimulus = tsl.patterns.StimuliRegion(
    temporal=eqn_t,
    connectivity=conn1,
    weight=stim_weights
)

# Configure the stimulus in time and space
stimulus.configure_space()
stimulus.configure_time(np.arange(498.75, 505.75, 0.001))

# Visualize the stimulation
tsl.plot_pattern(stimulus)
```

### 🧪 **Applications**

- Simulating realistic DBS input in brain network models  
- Comparing effects of stimulation frequencies, amplitudes, and pulse shapes  
- Investigating region-specific responses to stimulation  

### 📌 **Notes**

- Can be combined with `StimuliRegion` weights to target specific regions.  
- Fully compatible with TVB models and simulation pipelines.  
- Developed by **Lorenzo Prione**.

---
