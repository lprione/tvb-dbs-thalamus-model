    # Function to derive the desired statstics for comparison simulated with real data
def calculate_summary_statistics_func(raw_data, raw_time, eeg_data, eeg_time):
    import numpy as np

    raw_time /= (np.max(raw_time,0) - np.min(raw_time,0))
    eeg_time /= (np.max(eeg_time,0) - np.min(eeg_time,0))
    eeg_data /= (np.max(eeg_data,0) - np.min(eeg_data, 0))
    eeg_data -= np.mean(eeg_data,0)
    return eeg_data
