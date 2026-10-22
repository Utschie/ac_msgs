# Telemetry static snapshot (Windows -> Linux uplink). zenoh key
# "ac/telemetry_static", published only when the session changes; the same
# content is dumped by the bridge to the session's telemetry_static.jsonl.
std_msgs/Header header

uint32 session_epoch        # session counter from the game's telemetry page
uint32 num_cars
int32 sector_count
float32 max_torque          # Nm
float32 max_power           # hp
int32 max_rpm
float32 max_fuel            # l
float32[4] suspension_max_travel  # m, FL/FR/RL/RR
float32[4] tyre_radius            # m (unloaded), FL/FR/RL/RR
float32 max_turbo_boost
uint32 penalties_enabled
float32 aid_fuel_rate
float32 aid_tire_rate
float32 aid_mechanical_damage
float32 aid_stability
uint32 aid_allow_tyre_blankets
uint32 aid_auto_clutch
uint32 aid_auto_blip
uint32 has_drs
uint32 has_ers
uint32 has_kers
float32 kers_max_j          # J
float32 ers_max_j           # J
float32 track_spline_length # m
uint32 is_timed_race
uint32 has_extra_lap
int32 pit_window_start
int32 pit_window_end
string ac_version
string track
string track_config
string car_model
string car_skin
