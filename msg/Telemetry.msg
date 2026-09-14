# 车辆遥测（Win -> Lin 上行，v1 2026-09-13）。线格式：shared/zenoh_payload.h
# TelemetryPayload(692B) = {ts, frameId, physPacketId, incValid} + AC 官方
# acpmf SPageFilePhysics(580B 全量) + CarPhysicsState 增量(88B)。
# zenoh key "ac/telemetry"，每场景帧一条；frameId 与 ego_pose/cameras 同源
# 严格同帧，physPacketId 为 acpmf 物理包号（物理时间轴身份）。
# 字段语义/单位详见 shared/acpmf_shm.h（布局底本 ACTI sim_info_acti.py）。
std_msgs/Header header

# ---- 载荷头 ----
uint64 frame_id          # 场景 frameId（与 ego_pose 同源对齐锚点）
int32 phys_packet_id     # acpmf physics packetId（-1 = 撕裂）
uint32 inc_valid         # 1 = 下方 inc_* 增量字段有效（control SHM v4）

# ---- 驾驶输入 ----
float32 gas              # [0,1]
float32 brake            # [0,1]
float32 fuel             # l
int32 gear               # 0=R 1=N 2..8=1..7
int32 rpms
float32 steer_angle      # rad
float32 speed_kmh

# ---- 运动学 ----
float32[3] velocity            # 世界系 m/s
float32[3] acc_g               # 车体系 G
float32 heading                # rad
float32 pitch
float32 roll
float32 cg_height
float32[3] local_angular_vel   # rad/s 车体系
float32[3] local_velocity      # m/s 车体系

# ---- 轮胎×4（FL/FR/RL/RR）----
float32[4] wheel_slip
float32[4] wheel_load          # N
float32[4] wheels_pressure     # psi
float32[4] wheel_angular_speed # rad/s
float32[4] tyre_wear
float32[4] tyre_dirty_level
float32[4] tyre_core_temperature  # °C
float32[4] camber_rad
float32[4] suspension_travel      # m
float32[4] brake_temp             # °C
float32[4] tyre_temp_i            # 胎面内侧 °C
float32[4] tyre_temp_m            # 胎面中部 °C
float32[4] tyre_temp_o            # 胎面外侧 °C
float32[12] tyre_contact_point    # [x/y/z][4] 世界系
float32[12] tyre_contact_normal
float32[12] tyre_contact_heading

# ---- 车辆系统 ----
float32 drs
float32 tc
float32 abs
float32[5] car_damage      # 0-100（前/后/左/右/全体）
int32 number_of_tyres_out
int32 pit_limiter_on
int32 auto_shifter_on
float32[2] ride_height     # 前/后
float32 turbo_boost
float32 ballast
float32 air_density        # kg/m³
float32 air_temp           # °C
float32 road_temp          # °C
float32 final_ff
float32 performance_meter
int32 engine_brake
float32 clutch
float32 brake_bias

# ---- 电控混动 ----
float32 kers_charge
float32 kers_input
int32 ers_recovery_level
int32 ers_power_level
int32 ers_heat_charging
int32 ers_is_charging
float32 kers_current_kj
int32 drs_available
int32 drs_enabled
int32 is_ai_controlled

# ---- CarPhysicsState 增量（inc_valid=1 时有效；偏移出自 acs_pdbview.log）----
float32[4] inc_mz                 # 自回正力矩 Nm（+0x0304）
float32[4] inc_tyre_loaded_radius # m（+0x06FC）
float32 inc_drivetrain_speed      # rad/s（+0x0734）
float32 inc_aero_cd               # 气动阻力系数（+0x0670）
float32 inc_aero_cl_front
float32 inc_aero_cl_rear
float32[2] inc_caster             # rad 前轴（+0x0B64）
float32[4] inc_slip_angle         # rad（+0x02A4）
float32[4] inc_slip_ratio         #（+0x02B4）
