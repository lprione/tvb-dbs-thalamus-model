def config_sim_func(A_p, B_p, a_p, b_p, stim=None):
    
    import numpy as np
    import tvb.simulator.lab as tsl
    import tvb.datatypes.projections as projections
    from DBS import DBS_func
    
    conn1 = tsl.connectivity.Connectivity.from_file('DBS007_connectivity_374.zip'); #by putting inside 'filename.zip' you can upload your data
    conn_coupling = tsl.coupling.SigmoidalJansenRit();
    conn1.weights*=3
    conn1.configure();
    # conn1.summary_info
    
    jrm = tsl.models.JansenRit(variables_of_interest=["y1", "y2"],
                               A=np.ones(374)*np.array([3.25]),
                               B=np.ones(374)*np.array([22.0]),
                               a=np.ones(374)*np.array([0.15]), #5.0
                               b=np.ones(374)*np.array([0.05]))#2.5
    jrm.a[360] = np.array([4.5])
    jrm.b[360] = np.array([3.5])
    #jrm.a[367] = np.array([4.5])
    #jrm.b[367] = np.array([3.5])
    
                         # = region 2 in 76 conn and region 156 in 192 conn: right amygdala (electrode DBS channel)
    for i in range(374):  # Loop from 0 to 75
        if i == 360:# or i == 367:
            continue  # Skip index 2
        jrm.A[[i]] = np.ones(1) * A_p
        jrm.B[[i]] = np.ones(1) * B_p
        jrm.a[[i]] = np.ones(1) * a_p
        jrm.b[[i]] = np.ones(1) * b_p
        
    sigma = np.ones((6,374))*np.array([1.0])
    sigma[0,:] = np.array([0])
    sigma[2:6,:] = np.array([0])
    sigma[0:6,360] = np.array([0])
    #sigma[0:6,367] = np.array([0])

    heunint = tsl.integrators.HeunStochastic(dt=0.25, noise=tsl.noise.Additive(nsig=sigma))#1e-8
    
    pr = projections.ProjectionSurfaceEEG.from_file('scaled_projection_matrix_65_360.npy')
    ss = tsl.sensors.SensorsEEG.from_file()
    rm = tsl.region_mapping.RegionMapping.from_file('region_mapping_374.txt')
    
    mon_tavg = tsl.monitors.TemporalAverage(period=0.25) # 4096 Hz
    mon_EEG = tsl.monitors.EEG(projection=pr, sensors=ss, region_mapping=rm, period=0.25) # 4096 Hz
    # mon_SEEG = monitors.iEEG.from_file(region_mapping=rm, period=0.244140625)

    rec = (mon_tavg, mon_EEG)
    
    nodes = [360], #367]
    stim_weights = np.zeros((conn1.number_of_regions, ))
    stim_weights[nodes] = 1

    eqn_t = DBS_func()
    stimulus = tsl.patterns.StimuliRegion(temporal=eqn_t,
                                  connectivity=conn1,
                                  weight=stim_weights)
    
    stimulus.configure_space()
    stimulus.configure_time(np.arange(498.75, 505.75, 0.001))

    #And take a look
    tsl.plot_pattern(stimulus)
    
    sim = tsl.simulator.Simulator(model = jrm, 
                          connectivity = conn1,
                          coupling = conn_coupling, 
                          integrator = heunint, 
                          monitors = rec,
                          stimulus = stimulus)
                    
    sim.configure();
    
    return sim
