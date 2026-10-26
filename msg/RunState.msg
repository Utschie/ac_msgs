# Run boundary/state events (Windows -> Linux uplink). zenoh key
# "ac/run_state", driven by the bridge's run state machine (a handful of
# events per session); the same events are dumped by the bridge to the
# session's run_state.jsonl.
std_msgs/Header header

uint64 timestamp_ns        # event time (renderer clock)
uint32 event_type          # event type constant (see below)
uint32 reason_code         # RUN_END: 0=results_menu 1=restart 2=key_change
                           # 3=metadata_invalid 4=scene_stale
                           # 6=session_gen_change (online server session
                           # switch via session generation, M22)
                           # BARRIER: 5=session_gen_fuse
uint32 run_id              # N of runs/epoch_N (most recent when idle)
uint32 session_epoch       # GO counter
uint32 session_type        # 1..7 (same as GameState)
uint32 flags               # feedback flags snapshot at event time
uint32 flag_field          # when event_type=FLAG: which bit flipped (below)
string track
string car_model

uint32 EVENT_RUN_BEGIN = 0
uint32 EVENT_RUN_END = 1
uint32 EVENT_FLAG = 2
uint32 EVENT_BARRIER = 3
uint32 FLAG_FIELD_RACE_OVER = 0
uint32 FLAG_FIELD_SESSION_OVER = 1
uint32 FLAG_FIELD_RESULTS_MENU = 2
