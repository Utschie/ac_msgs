# 圈速/比赛状态（Win -> Lin 上行，v1 2026-09-13）。线格式：shared/zenoh_payload.h
# TimingPayload(316B) = {ts, frameId, gfxPacketId} + AC 官方 acpmf
# SPageFileGraphic(296B)。zenoh key "ac/timing"，每场景帧一条，frameId 与
# ego_pose 同源同帧。wchar 计时串在线格式中存在但 ROS 侧用整型毫秒字段。
std_msgs/Header header

uint64 frame_id
int32 gfx_packet_id

int32 status              # 0=OFF 1=REPLAY 2=LIVE 3=PAUSE
int32 session             # 0=练习 1=排位 2=正赛 3=hotlap 4=计时 5=漂移 6=直线
int32 completed_laps
int32 position            # 排名（1 起）
int32 i_current_time      # 本圈 ms
int32 i_last_time         # 上一圈 ms
int32 i_best_time         # 最快圈 ms
float32 session_time_left # s
float32 distance_traveled # m
int32 is_in_pit
int32 current_sector_index
int32 last_sector_time    # ms
int32 number_of_laps
string tyre_compound
float32 replay_time_multiplier
float32 normalized_car_position   # 0-1 圈内归一化
float32[3] car_coordinates        # 世界系 m
float32 penalty_time              # s
int32 flags                       # 0无 1蓝 2黄 3黑 4白 5格纹 6处罚
int32 ideal_line_on
int32 is_in_pit_lane
float32 surface_grip              # 0-1
int32 mandatory_pit_done
float32 wind_speed                # m/s
float32 wind_direction            # rad
