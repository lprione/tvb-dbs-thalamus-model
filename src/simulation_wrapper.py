def simulation_wrapper_func(params):
    """
    Returns summary statistics from conductance values in `params`.
    
    Summarizes the output of the HH simulator and converts it to `torch.Tensor`.
    """
    import torch
    import numpy as np
    from config_sim import config_sim_func
    from run_simulation import run_simulation_func
    from calculate_summary_statistics import calculate_summary_statistics_func
    
    params_epi = params.numpy()
    A_p, B_p, a_p, b_p = params_epi
    sim = config_sim_func(A_p, B_p, a_p, b_p);
    out = run_simulation_func(sim);
    
    obs_time = np.array(out[1])
    y = np.array(out[0])
    obs_raw_data = y[:, 0, :, 0] - y[:, 1, :, 0]
    
    obs_eeg_time = np.array(out[3])
    eeg = np.array(out[2])
    obs_eeg_data = eeg[:, 0, :, 0] - eeg[:, 1, :, 0]
    
#   if you want to to sensitivity analysis, remove summstats and decomment all the rest of the code
    summstats = torch.as_tensor(obs_eeg_data)
    
    return summstats
#    obs_eeg_data = torch.as_tensor(obs_eeg_data)

#    fs = 4
#    trial_period = 500 * fs
#    window_size = 250 * fs
#    pre_stimulus = 50 * fs

#    num_trials = int(obs_eeg_data.shape[0] // trial_period)

#    valid_trial_indices = torch.arange(1, num_trials - 1) * trial_period  # Skip first and last trial

#    trials = torch.stack([
#        obs_eeg_data[max(0, idx - pre_stimulus) : min(obs_eeg_data.shape[0], idx - pre_stimulus + window_size),:]
#        for idx in valid_trial_indices
#    ], dim=0)

#    avg_trials_per_channel = trials.mean(dim=0)

#    arr = avg_trials_per_channel.numpy()
#    gmfp = np.sqrt(((arr - arr.mean(axis=1, keepdims=True)) ** 2).mean(axis=1))

#    return gmfp
