# 专家操作上行（Win -> Lin，v5 模仿学习）。线格式：shared/zenoh_payload.h
# ExpertCtrlPayload(44B)，zenoh key "ac/expert_ctrl"，由 ac_sim_bridge 主循环
# 每场景帧发布（frame_id 与 ac/ego_pose 的 frame_id 同源严格对齐——模仿学习
# 的 (观测, 动作) 配对锚点）。
#
# 值 = acquireControls detour 快照的"实际施加控制"：
#   人类专家驾驶时 = 设备原生输入（方向盘/踏板）；自动驾驶接管时 = 覆盖值
#   （此时 override=true，训练时应过滤这些样本）。
std_msgs/Header header

# 场景帧号（与 /ac/ego_pose 的 frame_id 一致——配对键）
uint64 frame_id

# 方向盘 [-1, 1]（负=左，正=右）
float32 steer

# 油门 [0, 1]
float32 throttle

# 刹车 [0, 1]
float32 brake

# 离合 [0, 1]
float32 clutch

# 手刹 [0, 1]
float32 hand_brake

# 本帧窗口内出现过的升挡 / 降挡动作（0/1，边沿脉冲）
bool gear_up
bool gear_dn

# true = 该值是自动驾驶接管时的输出（非人类专家，训练时过滤）
bool override
