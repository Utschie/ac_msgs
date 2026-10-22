# Lap timing / race state (Windows -> Linux uplink). zenoh key
# "ac/timing", one message per scene frame, frame-aligned with ego_pose.
# The wide-char timing strings exist in the wire format but the ROS side
# carries the same information as integer millisecond fields.
std_msgs/Header header

uint64 frame_id
int32 gfx_packet_id

int32 status              # 0=OFF 1=REPLAY 2=LIVE 3=PAUSE
int32 session             # 0=practice 1=qualifying 2=race 3=hotlap 4=time attack 5=drift 6=drag
int32 completed_laps
int32 position            # standings (1-based)
int32 i_current_time      # current lap, ms
int32 i_last_time         # last lap, ms
int32 i_best_time         # best lap, ms
float32 session_time_left # s
float32 distance_traveled # m
int32 is_in_pit
int32 current_sector_index
int32 last_sector_time    # ms
int32 number_of_laps
string tyre_compound
float32 replay_time_multiplier
float32 normalized_car_position   # 0-1 position within the lap
float32[3] car_coordinates        # Z-up world frame, m
float32 penalty_time              # s
int32 flags                       # 0 none 1 blue 2 yellow 3 black 4 white 5 checkered 6 penalty
int32 ideal_line_on
int32 is_in_pit_lane
float32 surface_grip              # 0-1
int32 mandatory_pit_done
float32 wind_speed                # m/s
float32 wind_direction            # rad
