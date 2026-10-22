# Vehicle control command (Linux -> Windows downlink). zenoh key
# "ac/vehicle_cmd", packed and forwarded by ac_ros2_bridge's ControlRelay.
# Gear encoding: 0=R, 1=N, 2..8 = gears 1..7, independent of session type.
std_msgs/Header header

# Master switch: false = bridge forwards values only, plugin does not take
# over (human keeps driving); true = take over. Commands stop being
# published for ~0.5 s and control falls back to the human automatically —
# no need to explicitly send false.
bool override_enabled

# Analog values. Semantics depend on the Windows-side control.ini MODE:
#   shm  = final normalized values written directly to the game's control
#          block (recommended for model interfaces, well-defined semantics)
#   vjoy = virtual wheel/pedals through the game's native input pipeline
#          (affected by rotation range / gamma / dead zones)
float32 steering            # [-1, 1]
float32 throttle            # [0, 1]
float32 brake               # [0, 1]
float32 clutch              # [0, 1]
float32 hand_brake          # [0, 1]

# Absolute gear: 0=R 1=N 2..8=1..7; GEAR_NO_CHANGE = keep current gear.
# The vJoy backend approximates absolute gears with per-gear pulses +
# gear feedback; the SHM backend writes them directly.
# Warning: this field's default value is 0 (= reverse!). If you publish
# without setting it explicitly the car drops into reverse. Send -100 to
# keep the current gear.
int32 requested_gear_index
int32 GEAR_NO_CHANGE=-100

# Buttons (press events; edge-detected 0->1 on the plugin side, mapped to
# device buttons 1/2 on the vJoy side).
bool gear_up
bool gear_dn
bool drs
bool kers
# Force hand_brake to 1 (overrides the hand_brake float value)
bool handbrake_on
