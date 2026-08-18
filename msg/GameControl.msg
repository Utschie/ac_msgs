# 游戏会话控制命令（Lin -> Win 下行）。线格式：shared/zenoh_payload.h
# GameControlPayload(4B)，zenoh key "ac/game_cmd"。与 VehicleControl（纯驾驶）分离。
# 全部为**边沿语义**：bridge 收到后保持 ~0.5s 自动清零，插件在 0->1 跳变时
# 触发一次对应游戏函数；重复触发 = 再发一条。
std_msgs/Header header

# 开始比赛（HUD"开始游戏"按钮标准链路：Sim::startGame → 淡入 → 边栏消失 →
# 操控解锁 → 10s 灯序倒计时）。倒计时已开始/比赛已开时置位无效。
bool start_race

# 暂停物理（Sim::setPauseMode(true)）
bool pause

# 恢复物理（Sim::setPauseMode(false)）
bool resume

# 重开当前会话（RaceManager::restartCurrentSession，回发车位重来）
bool restart_session

# 跳到下一会话（RaceManager::skipCurrentSession，如练习→排位→正赛推进）
bool skip_session
