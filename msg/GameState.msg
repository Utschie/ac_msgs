# 游戏会话状态反馈（Win -> Lin 上行）。线格式：shared/zenoh_payload.h
# GameStatePayload(16B)，zenoh key "ac/game_state"。
std_msgs/Header header

# 会话类型（PDB SessionType 枚举）
uint8 SESSION_UNDEFINED=0
uint8 SESSION_PRATICE=1
uint8 SESSION_QUALIFY=2
uint8 SESSION_RACE=3
uint8 SESSION_HOTLAP=4
uint8 SESSION_TIMEATTACK=5
uint8 SESSION_DRIFT=6
uint8 SESSION_DRAG=7
uint8 session_type

# 发车信号：红灯倒计时结束熄灯（race live，自动驾驶可起步）
bool race_live

# 发车灯当前点亮中（倒计时进行）
bool countdown_lights
