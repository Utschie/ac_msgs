# ac_msgs

ROS 2 message definitions for the AC Simulator Suite's ROS bridge.

Used by [ac_ros2_bridge](https://github.com/Utschie/ac_ros2_bridge) to talk
to the suite's Windows-side bridge over Zenoh, and by your downstream stack
(planning / control / imitation learning) to consume and command the
simulation.

## Messages

| Message | Direction | Purpose |
|---|---|---|
| `VehicleControl` | ROS → game | Driving commands (steering / throttle / brake / clutch / handbrake / gear / buttons / override switch). Publish to `/ac/vehicle_cmd` at a steady rate (≥ 20 Hz recommended); stop publishing ≈ 0.5 s to hand control back to the human. RELIABLE QoS. |
| `VehicleState` | game → ROS | Gear / speed (m/s) / race-start flags, `/ac/vehicle_state` |
| `GameState` | game → ROS | Session type and flags, `/ac/game_state` |
| `GameControl` | ROS → game | Session control (start / pause / resume / restart), `/ac/game_cmd` |
| `ExpertCtrl` | game → ROS | Per-frame expert driving actions, `/ac/expert_ctrl` — frame-aligned with `/ac/ego_pose`, i.e. (observation, action) pairs for imitation learning |
| `Telemetry` | game → ROS | Full physics telemetry, `/ac/telemetry` (one message per scene frame) |
| `Timing` | game → ROS | Lap timing / race state, `/ac/timing` |
| `TelemetryStatic` | game → ROS | Car / track constants snapshot, `/ac/telemetry_static` (latched) |
| `RunState` | game → ROS | Run boundary events (begin / end / flag), `/ac/run_state` |

Conventions: gear `0=R, 1=N, 2..8 = gears 1..7` (`-100` = no change);
wheel arrays are ordered FL / FR / RL / RR. All data follows the suite-wide
coordinate convention (X fwd / Y left / Z up; world Z = height) — see the
suite's data-format documentation.

## Build

```bash
colcon build --packages-select ac_msgs
source install/setup.bash
ros2 interface show ac_msgs/msg/VehicleControl
```

Requires ROS 2 Humble or newer.
