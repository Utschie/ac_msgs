# Vehicle telemetry (Windows -> Linux uplink). zenoh key "ac/telemetry",
# one message per scene frame; frameId is strictly frame-aligned with
# ego_pose/cameras, and physPacketId is the game's physics packet counter
# (the physics-timeline identity). Field semantics/units: see the suite's
# data-format documentation.
std_msgs/Header header

# ---- Payload header ----
uint64 frame_id          # scene frame id (alignment anchor with ego_pose)
int32 phys_packet_id     # physics packet id (-1 = torn read)
uint32 inc_valid         # 1 = the inc_* increment fields below are valid

# ---- Driver inputs ----
float32 gas              # [0,1]
float32 brake            # [0,1]
float32 fuel             # l
int32 gear               # 0=R 1=N 2..8=1..7
int32 rpms
float32 steer_angle      # rad (positive = steering right)
float32 speed_kmh

# ---- Kinematics ----
# Coordinates follow the suite-wide convention: velocity / tyre_contact_*
# are in the Z-up world frame; acc_g / local_* are in the body frame
# (x fwd, y left, z up — positive directions consistent with it).
float32[3] velocity            # Z-up world frame, m/s
float32[3] acc_g               # body-frame G (x fwd / y left / z up; ~0 at rest, dynamic only, gravity excluded)
float32 heading                # rad heading (compass-style clockwise: 0 = fwd, +90 = right; world azimuth = -heading)
float32 pitch
float32 roll
float32 cg_height
float32[3] local_angular_vel   # rad/s body frame (z = yaw, left turn positive)
float32[3] local_velocity      # m/s body frame (x = fwd)

# ---- Tyres x4 (FL/FR/RL/RR) ----
float32[4] wheel_slip
float32[4] wheel_load          # N
float32[4] wheels_pressure     # psi
float32[4] wheel_angular_speed # rad/s
float32[4] tyre_wear
float32[4] tyre_dirty_level
float32[4] tyre_core_temperature  # degC
float32[4] camber_rad
float32[4] suspension_travel      # m
float32[4] brake_temp             # degC
float32[4] tyre_temp_i            # inner tread, degC
float32[4] tyre_temp_m            # middle tread, degC
float32[4] tyre_temp_o            # outer tread, degC
float32[12] tyre_contact_point    # [x/y/z][FL/FR/RL/RR] Z-up world frame
float32[12] tyre_contact_normal   # [x/y/z][FL/FR/RL/RR]
float32[12] tyre_contact_heading  # [x/y/z][FL/FR/RL/RR]

# ---- Vehicle systems ----
float32 drs
float32 tc
float32 abs
float32[5] car_damage      # 0-100 (front/rear/left/right/overall)
int32 number_of_tyres_out
int32 pit_limiter_on
int32 auto_shifter_on
float32[2] ride_height     # front/rear
float32 turbo_boost
float32 ballast
float32 air_density        # kg/m^3
float32 air_temp           # degC
float32 road_temp          # degC
float32 final_ff
float32 performance_meter
int32 engine_brake
float32 clutch
float32 brake_bias

# ---- Hybrid / ERS ----
float32 kers_charge
float32 kers_input
int32 ers_recovery_level
int32 ers_power_level
int32 ers_heat_charging
int32 ers_is_charging
float32 kers_current_kj
int32 drs_available
int32 drs_enabled
int32 is_ai_controlled

# ---- Physics-state increments (valid when inc_valid=1) ----
# [4] wheel arrays ordered as above: FL/FR/RL/RR.
float32[4] inc_mz                 # self-aligning torque, Nm
float32[4] inc_tyre_loaded_radius # m, FL/FR/RL/RR
float32 inc_drivetrain_speed      # rad/s
float32 inc_aero_cd               # aero drag coefficient
float32 inc_aero_cl_front
float32 inc_aero_cl_rear
float32[2] inc_caster             # rad, front-axle left/right
float32[4] inc_slip_angle         # rad, FL/FR/RL/RR
float32[4] inc_slip_ratio         # FL/FR/RL/RR
