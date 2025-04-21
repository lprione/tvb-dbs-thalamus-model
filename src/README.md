
# TVB Head Model Visualization

This folder contains the script `plot_tvb_headmodel.m`, which provides a 3D visualization of a head model based on structural data from *The Virtual Brain* (TVB).

## 📋 Description

The script visualizes the cortical and scalp surfaces, along with region centers. Selected nodes (such as the amygdala) can be highlighted for clarity.

## 🧠 Features

- Loads surface meshes of cortex and scalp
- Plots region centers based on TVB data
- Highlights selected brain regions (e.g., amygdala)
- Customizable and ready for screenshot or export

## 📁 Required Input Files

- `cortex/vertices.txt`, `cortex/triangles.txt`  
- `face/vertices.txt`, `face/triangles.txt`  
- `centers.txt` — coordinates of 76 TVB regions

These files were generated using the TVB software with a 76-node connectivity matrix.

## 🖼 Output

- A 3D figure of the head model with surfaces and regional nodes
- Optionally saves the figure as `tvb_headmodel.png`

## 🔧 How to Use

Open the script in MATLAB and run:

```matlab
plot_tvb_headmodel
```

Make sure all input files are in the correct relative paths.

## 📌 Notes

- Highlighted nodes can be customized via the `highlight_nodes` variable.
- This script is mainly for visual validation of brain region mapping.

---

Developed by Lorenzo Prione.
