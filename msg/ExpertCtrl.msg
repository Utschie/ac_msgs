# Expert driving actions uplink (Windows -> Linux, for imitation learning).
# zenoh key "ac/expert_ctrl", published by the bridge once per scene frame
# (frame_id strictly aligned with ac/ego_pose — the (observation, action)
# pairing anchor for imitation learning).
#
# Values are the actually-applied controls, snapshotted from the game's
# control-acquisition path: while the human expert drives they are the raw
# device inputs (wheel/pedals); while the autonomy stack overrides they are
# the override values (override=true — filter these samples when training).
std_msgs/Header header

# Scene frame id (identical to /ac/ego_pose's frame_id — the pairing key)
uint64 frame_id

# Steering wheel [-1, 1] (negative = left, positive = right)
float32 steer

# Throttle [0, 1]
float32 throttle

# Brake [0, 1]
float32 brake

# Clutch [0, 1]
float32 clutch

# Hand brake [0, 1]
float32 hand_brake

# Gear-up / gear-down action within this frame's window (0/1, edge pulse)
bool gear_up
bool gear_dn

# true = value produced while the autonomy stack was overriding (not the
# human expert — filter when training)
bool override
