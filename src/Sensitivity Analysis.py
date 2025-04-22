
# Sensitivity Analysis for TVB-DBS Model using Simulation-Based Inference (SBI)
#
# This script performs posterior inference on model parameters and sensitivity analysis
# via Active Subspaces, using the sbi and torch libraries.
#
# Parameters inferred: A, B, a, b (related to the Jansen-Rit neural mass model)

from simulation_wrapper import simulation_wrapper_func  # Custom simulator function (DBS model simulation)
from sbi.analysis import ActiveSubspace, pairplot
from torch.distributions import MultivariateNormal
from sbi.simulators import linear_gaussian
from sbi.utils import BoxUniform
from sbi.inference import SNPE, simulate_for_sbi, prepare_for_sbi, infer
import time as tm
import torch

# Define prior ranges for the parameters [A, B, a, b]
# A: Average excitatory synaptic gain
# B: Average inhibitory synaptic gain
# a: Time constant of excitatory synapses
# b: Time constant of inhibitory synapses
prior_min = [2.6, 17.6, 0.05, 0.025]
prior_max = [9.75, 110.0, 0.15, 0.075]
prior_jr = BoxUniform(low=torch.as_tensor(prior_min), high=torch.as_tensor(prior_max))

# Perform simulation-based inference using Sequential Neural Posterior Estimation (SNPE)
posterior = infer(
    simulation_wrapper_func,          # Simulator function for generating data
    prior_jr,                         # Prior distribution over parameters
    num_simulations=100000,           # Number of simulations for training the neural posterior
    num_workers=128,                  # Parallel workers (adjust based on your system)
    method="SNPE"                     # Inference method: Sequential Neural Posterior Estimation
).set_default_x(torch.zeros(1000))    # Set default observed data (adjust as needed)

# Sample 1 million parameter sets from the posterior
posterior_samples = posterior.sample((1000000,))

# Generate a corner plot (pairplot) of the posterior samples
pairplot(
    posterior_samples,
    limits=[[2.6, 9.75], [17.6, 110.0], [0.05, 0.15], [0.025, 0.075]],
    figsize=(4, 4),
    labels=[r"$A$", r"$B$", r"$a$", r"$b$"]
)

# Perform Active Subspace sensitivity analysis
sensitivity = ActiveSubspace(posterior)
e_vals, e_vecs = sensitivity.find_directions(posterior_log_prob_as_property=True)

# Print eigenvalues (importance of each direction)
print("Eigenvalues (sensitivity directions):", e_vals)
