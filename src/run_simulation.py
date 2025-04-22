def run_simulation_func(sim):
    
    import numpy as np
    import time as tm

    raw_data = []
    raw_time = []
    eeg_data = []
    eeg_time = []
    
    # Perform the simulation.
    #print("Starting simulation...")
    tic = tm.time()
    
    for raw, eeg in sim(simulation_length=3e4):
        
            if not raw is None:
                raw_time.append(raw[0])
                raw_data.append(raw[1])
            
            if not eeg is None:
                eeg_time.append(eeg[0])
                eeg_data.append(eeg[1])
            
    
    # Finished simulation. 
    #print("Finished simulation.")
    #print("execute for " + str(tm.time()-tic))

    return (raw_data, raw_time, eeg_data, eeg_time)