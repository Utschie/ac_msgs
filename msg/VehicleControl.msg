# 车辆控制命令（Lin -> Win 下行）。线格式：shared/zenoh_payload.h ControlPayload(32B)，
# zenoh key "ac/vehicle_cmd"，由 ac_ros2_bridge 的 ControlRelay 打包转发。
# 挡位编码（实测定案）：0=R 1=N 2..8=1..7 挡，与会话类型无关。
std_msgs/Header header

# 总开关：false = bridge 只转发值、插件不接管（人类继续驾驶）；true = 接管。
# 停止发布命令后 ~0.5s（bridge RX_TIMEOUT_MS）自动弃权回人工，无需显式发送 false。
bool override_enabled

# 模拟量。语义随 Windows 端 bridge_control.ini 的 MODE 不同：
#   shm  = 最终归一化量直写 CarControls（模型接口推荐，语义确定）
#   vjoy = 虚拟方向盘/踏板，经 AC 原生输入处理（受旋转角度/gamma/死区影响）
float32 steering            # [-1, 1]
float32 throttle            # [0, 1]
float32 brake               # [0, 1]
float32 clutch              # [0, 1]
float32 hand_brake          # [0, 1]

# 绝对挡位：0=R 1=N 2..8=1..7；GEAR_NO_CHANGE=保持当前挡位。
# vJoy 后端用"逐挡脉冲+挡位反馈"逼近绝对挡位；SHM 后端直写。
# ⚠️ 陷阱：本字段默认值是 0（= R 挡！）。ros2 topic pub 若不显式写此字段，
# 车会被挂到倒挡（实测 2026-08-18）。要"保持当前挡位"必须显式发 -100。
int32 requested_gear_index
int32 GEAR_NO_CHANGE=-100

# 按钮类（按压事件；插件侧 0->1 边沿检测，vJoy 侧映射到设备按钮 1/2）。
bool gear_up
bool gear_dn
bool drs
bool kers
# 强制 hand_brake=1（优先于 hand_brake 浮点值）
bool handbrake_on
