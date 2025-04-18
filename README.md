# Multiscale DBS Model – ANT Thalamus

This repository contains the simulation code and documentation for the MSc thesis:

📘 **"A multiscale computational model of Deep Brain Stimulation of the Anterior Nucleus of the Thalamus for epilepsy treatment"**  
🎓 Author: Lorenzo Prione (University of Genoa, University of Twente)  
🧠 Supervisor: Dr. M. C. Piastra | Co-supervisor: Prof. S. Martinoia

---

## 🔬 Background

Epilepsy affects over 50 million people worldwide, with ~30% resistant to pharmacological treatment. Deep Brain Stimulation (DBS) of the Anterior Nucleus of the Thalamus (ANT) has proven clinically effective, though its mechanisms are not fully understood.

This project explores the neurophysiological effects of ANT-DBS using **The Virtual Brain (TVB)** and a **neural mass model (Jansen-Rit)**, bridging biophysical modeling and EEG data comparison.

---

## 🛠️ Tools & Technologies

- 🐍 Python (3.x)
- 📦 The Virtual Brain (TVB)
- 📊 MATLAB (GMFP, signal processing)
- 🧠 EEG real data (synthetic example provided)
- 💻 Linux/Windows + Jupyter Notebooks

---

## 📁 Repository Structure

```text
tvb-dbs-thalamus-model/
├── src/           # Simulation and analysis scripts
├── notebooks/     # Interactive exploration and plotting
├── data/          # Example/mock datasets
├── requirements.txt
├── LICENSE
└── README.md
```

---

## 🚀 How to Run

> ⚠️ Currently under setup – check back soon for full documentation.

To install dependencies (after setting up your Python environment):
```bash
pip install -r requirements.txt
```

To run a simulation:
```bash
python src/simulate_dbs.py
```

---

## 📊 Example Output

- Simulated EEG time series
- Global Mean Field Power (GMFP) plots
- Topographic brain activity maps

![placeholder image](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Brain_activity_topography_example.svg/640px-Brain_activity_topography_example.svg.png)

---

## 📄 Thesis

🧾 You can find the final MSc thesis [here (link)](https://...) *(to be updated once available)*

---

## 👨‍💻 Author

**Lorenzo Prione**  
lorenzoprione@gmail.com  
[LinkedIn](https://www.linkedin.com/in/lorenzoprione) | [GitHub](https://github.com/lorenzoprione)

---

## 📜 License

MIT License – see `LICENSE` file for details.
