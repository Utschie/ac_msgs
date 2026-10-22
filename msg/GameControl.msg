# Game session control command (Linux -> Windows downlink). zenoh key
# "ac/game_cmd". Separate from VehicleControl (pure driving).
# All fields are **edge-triggered**: the bridge holds them for ~0.5 s then
# auto-clears; the plugin fires the corresponding game action once per
# 0->1 transition. To trigger again, send another message.
std_msgs/Header header

# Start the race (standard "start game" flow: fade-in, side panels hide,
# controls unlock, 10 s light-sequence countdown). No effect if the
# countdown has already started or the race is already live.
bool start_race

# Pause physics
bool pause

# Resume physics
bool resume

# Restart the current session (back to the grid)
bool restart_session

# Skip to the next session (e.g. practice -> qualifying -> race)
bool skip_session
