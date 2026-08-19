# 车辆状态反馈（Win -> Lin 上行）。线格式：shared/zenoh_payload.h VehicleStatePayload(20B)，
# zenoh key "ac/vehicle_state"，由 ac_sim_bridge 从 gamehook_control.hk 写入
# AC_ControlCache_v1 的反馈块读出转发。
std_msgs/Header header

# 挡位（编码实测定案）：0=R 1=N 2..8=1..7 挡
int32 gear

# CarPhysicsState.speed 原始值，单位 m/s（实测定案 2026-08-18；出生/维修区瞬间
# 可能读到假值，勿以单次读数下结论）
float32 speed

# 见 shared/control_shm.h FLAG_FEEDBACK_*：
#   bit0 = GO（发车信号：红灯倒计时结束熄灯，自动驾驶可以起步）
#   bit1 = 发车灯当前点亮中（倒计时进行）
uint32 flags
