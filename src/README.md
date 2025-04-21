
# TVB-DBS-Thalamus-Model – Source Code Overview

This folder contains core MATLAB scripts used for analyzing and visualizing simulation results from the TVB-based DBS thalamic model. It includes both EEG analysis tools and 3D brain model visualization.

---

## 🧪 EEG Analysis (FieldTrip)

`analyze_simulated_eeg.m` provides an end-to-end pipeline for analyzing simulated EEG signals derived from DBS models, using the [FieldTrip](https://www.fieldtriptoolbox.org/) toolbox.

### 📋 Features

- **Artifact rejection** based on thresholding and statistical methods  
- **Epoching** of data around DBS stimulation events  
- **ERP (Event-Related Potentials)** and **GMFP (Global Mean Field Power)** computation  
- **Topographical plotting** of neural activity across electrodes and time  

### 🛠 Requirements

- MATLAB  
- [FieldTrip Toolbox](https://www.fieldtriptoolbox.org/)  
- EEG simulation output from your TVB/DBS model  

---

## 🧠 TVB Head Model Visualization

`plot_tvb_headmodel.m` provides a 3D visualization of a head model based on structural data from *The Virtual Brain* (TVB). It is mainly used to validate and illustrate brain region positioning and mesh structure.

### 📋 Features

- Loads surface meshes of cortex and scalp  
- Plots regional centers derived from a 76-node connectivity matrix  
- Highlights custom-defined regions (e.g., amygdala)  
- Supports figure export for documentation or presentations  

### 📁 Required Input Files

- `cortex/vertices.txt`, `cortex/triangles.txt`  
- `face/vertices.txt`, `face/triangles.txt`  
- `centers.txt` — XYZ coordinates of TVB-defined brain regions  

> These files were exported using the TVB GUI with a connectivity setup of **76 brain regions**.

### 🖼 Output

- A 3D figure of the head model with mesh surfaces and highlighted region centers  
- Optional export to `tvb_headmodel.png`

### 🔧 How to Use

Open the script in MATLAB and run:

```matlab
plot_tvb_headmodel
```

Ensure input files are located in their expected folders.

---

## 📌 Notes

- Both scripts are designed to be modular and adaptable to custom models.  
- You may modify node selections or plotting styles depending on your region of interest.  
- Scripts are well-suited for integration into broader pipelines for TVB or neurostimulation modeling.

---

Developed by Lorenzo Prione.
