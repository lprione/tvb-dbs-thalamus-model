from tvb.basic.neotraits.api import Final, Attr
import tvb.simulator.lab as tsl

class DBS_func(tsl.equations.TemporalApplicableEquation):
    """
    A pulse train, offset with respect to the time axis, with an optional negative exponential decay after the first positive pulse.

    **Parameters**:

    * :math:\tau (float): Pulse width or pulse duration in milliseconds.
    * :math:T (float): Pulse repetition period in milliseconds.
    * onset (float): Time of the first pulse in milliseconds.
    * amp (float): Amplitude of the positive pulse.
    * tau_decay (float): Time constant of the exponential decay in milliseconds.
    * amp_exp (float): Amplitude of the exponential decay.
    """

    equation = Final(
        label="DBS",
        default=(
            "where((var > onset) & (((var - onset) % T) < tau), -amp, "
            "where((var > onset) & (((var - onset) % T) >= tau + 1) & (((var - onset) % T) < T), "
            "amp_exp * exp(-((var - onset - tau) % T) / tau_decay), 0))"
        ),
        doc=r""":math:\left\{\begin{array}{rl}
        -amp, & \text{if } ((var-onset) \mod T) < \tau \text{ and } var > onset\\
        amp_exp \cdot e^{-\frac{((var-onset)-\tau) \mod T}{\tau_{decay}}}, & \text{if } \tau \leq ((var-onset) \mod T) < T \text{ and } var > onset\\
        0, & \text{otherwise }
        \end{array}\right."""
    )

    parameters = Attr(
        field_type=dict,
        default=lambda: {
            "T": 500,
            "tau": 1,
            "amp": 4e9,
            "tau_decay": 1,
            "onset": 500,
            "amp_exp":5e9
        },
        label="DBS Parameters"
    )
