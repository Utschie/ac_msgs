# ac_msgs

AC ↔ ROS2 桥接的控制/状态消息定义（ament_cmake + rosidl 接口包）。与 `shared/`
的线格式契约一一对应，由 `ac_ros2_bridge`（转发）与下游自动驾驶栈（发布/订阅）使用。

## 消息

| 消息 | 方向 | 用途 | 线格式对应 |
|---|---|---|---|
| `VehicleControl` | ROS → bridge → 游戏 | 驾驶命令（转向/油门/刹车/离合/手刹/挡位/按钮/接管开关），发布到 `/ac/vehicle_cmd`，**RELIABLE QoS、定频流式（建议 ≥20Hz）**；停止发布 ≈0.5s 后自动弃权回人工 | `shared/zenoh_payload.h` `ControlPayload`(32B)，zenoh key `ac/vehicle_cmd` |
| `VehicleState` | 游戏 → bridge → ROS | 挡位/车速/GO 发车信号反馈，`/ac/vehicle_state` | `VehicleStatePayload`(20B)，key `ac/vehicle_state` |

## 定案约定（实测定案，改动须同步 shared/ 与 ac_sim_bridge/）

- **挡位编码**：`0=R、1=N、2..8=1..7 挡`；`GEAR_NO_CHANGE=-100` 哨兵表示不改挡
- **按钮边沿语义**：`gear_up/gear_dn` 为按压事件（插件 0→1 边沿检测，一帧一挡；
  挡位链线性 `R↔N↔1..7`，跨挡由后端逐挡逼近）
- **GO 信号**（`VehicleState.flags` bit0）：正赛红灯倒计时结束熄灯即 GO——
  自动驾驶栈以它决定起步时机；bit1=倒计时进行中
- **速度单位**：`VehicleState.speed` 为 `CarPhysicsState.speed` 原始值，
  **单位待定案（疑似 m/s）**——定案前下游自行确认

## 构建

```bash
colcon build --packages-select ac_msgs
source install/setup.bash
ros2 interface show ac_msgs/msg/VehicleControl
```

## 依赖

- ROS2（Humble/Jazzy 均可）+ `rosidl_default_generators`（标准组件，随 base 装）
- 线格式源头 `../shared/zenoh_payload.h`（本包注释与其保持同步，
  由 `ac_ros2_bridge/test_decode.py` 守护一致性）
