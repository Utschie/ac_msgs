# Vehicle state feedback (Windows -> Linux uplink). zenoh key
# "ac/vehicle_state", forwarded by the bridge from the control feedback
# block.
std_msgs/Header header

# Gear: 0=R, 1=N, 2..8 = gears 1..7
int32 gear

# Vehicle speed in m/s (transient bogus values possible right after spawn
# or in the pit area — don't judge from a single sample)
float32 speed

# flags bits:
#   bit0 = GO (race start: start lights went out after the countdown;
#              the autonomy stack may launch)
#   bit1 = start lights currently on (countdown in progress)
uint32 flags
