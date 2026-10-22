# Game session state feedback (Windows -> Linux uplink). zenoh key
# "ac/game_state".
std_msgs/Header header

# Session type
uint8 SESSION_UNDEFINED=0
uint8 SESSION_PRATICE=1
uint8 SESSION_QUALIFY=2
uint8 SESSION_RACE=3
uint8 SESSION_HOTLAP=4
uint8 SESSION_TIMEATTACK=5
uint8 SESSION_DRIFT=6
uint8 SESSION_DRAG=7
uint8 session_type

# Race start signal: start lights went out after the countdown (race live,
# the autonomy stack may launch)
bool race_live

# Start lights currently on (countdown in progress)
bool countdown_lights
