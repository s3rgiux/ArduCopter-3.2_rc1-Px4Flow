/// -*- tab-width: 4; Mode: C++; c-basic-offset: 4; indent-tabs-mode: nil -*-
/*
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*
 *  ArduCopter parameter definitions
 *
 */

#define GSCALAR(v, name, def) { g.v.vtype, name, Parameters::k_param_ ## v, &g.v, {def_value : def} }
#define ASCALAR(v, name, def) { aparm.v.vtype, name, Parameters::k_param_ ## v, &aparm.v, {def_value : def} }
#define GGROUP(v, name, class) { AP_PARAM_GROUP, name, Parameters::k_param_ ## v, &g.v, {group_info : class::var_info} }
#define GOBJECT(v, name, class) { AP_PARAM_GROUP, name, Parameters::k_param_ ## v, &v, {group_info : class::var_info} }
#define GOBJECTN(v, pname, name, class) { AP_PARAM_GROUP, name, Parameters::k_param_ ## pname, &v, {group_info : class::var_info} }

const AP_Param::Info var_info[] PROGMEM = {
    // @Param: SYSID_SW_MREV
    // @DisplayName: Eeprom format version number
    // @Description: This value is incremented when changes are made to the eeprom format
    // @User: Advanced
    GSCALAR(format_version, "SYSID_SW_MREV",   0),

    // @Param: SYSID_SW_TYPE
    // @DisplayName: Software Type
    // @Description: This is used by the ground station to recognise the software type (eg ArduPlane vs ArduCopter)
    // @User: Advanced
    GSCALAR(software_type,  "SYSID_SW_TYPE",   Parameters::k_software_type),

    // @Param: SYSID_THISMAV
    // @DisplayName: Mavlink version
    // @Description: Allows reconising the mavlink version
    // @Range: 1 255
    // @User: Advanced
    GSCALAR(sysid_this_mav, "SYSID_THISMAV",   MAV_SYSTEM_ID),

    // @Param: SYSID_MYGCS
    // @DisplayName: My ground station number
    // @Description: Allows restricting radio overrides to only come from my ground station
    // @Range: 1 255
    // @User: Advanced
    GSCALAR(sysid_my_gcs,   "SYSID_MYGCS",     255),

    // @Param: SERIAL1_BAUD
    // @DisplayName: Telemetry Baud Rate
    // @Description: The baud rate used on the first telemetry port
    // @Values: 1:1200,2:2400,4:4800,9:9600,19:19200,38:38400,57:57600,111:111100,115:115200
    // @User: Standard
    GSCALAR(serial1_baud,   "SERIAL1_BAUD",     SERIAL1_BAUD/1000),

#if MAVLINK_COMM_NUM_BUFFERS > 2
    // @Param: SERIAL2_BAUD
    // @DisplayName: Telemetry Baud Rate
    // @Description: The baud rate used on the seconds telemetry port
    // @Values: 1:1200,2:2400,4:4800,9:9600,19:19200,38:38400,57:57600,111:111100,115:115200
    // @User: Standard
    GSCALAR(serial2_baud,   "SERIAL2_BAUD",     SERIAL2_BAUD/1000),
#endif

    // @Param: TELEM_DELAY
    // @DisplayName: Telemetry startup delay
    // @Description: The amount of time (in seconds) to delay radio telemetry to prevent an Xbee bricking on power up
    // @User: Advanced
    // @Units: seconds
    // @Range: 0 10
    // @Increment: 1
    GSCALAR(telem_delay,            "TELEM_DELAY",     0),

    // @Param: RTL_ALT
    // @DisplayName: RTL Altitude
    // @Description: The minimum altitude the model will move to before Returning to Launch.  Set to zero to return at current altitude.
    // @Units: Centimeters
    // @Range: 0 8000
    // @Increment: 1
    // @User: Standard
    GSCALAR(rtl_altitude,   "RTL_ALT",     RTL_ALT),

    // @Param: SONAR_ENABLE
    // @DisplayName: Sonar enable/disable
    // @Description: Setting this to Enabled(1) will enable the sonar. Setting this to Disabled(0) will disable the sonar
    // @Values: 0:Disabled,1:Enabled
    // @User: Standard
    GSCALAR(sonar_enabled,  "SONAR_ENABLE",     DISABLED),

    // @Param: SONAR_TYPE
    // @DisplayName: Sonar type
    // @Description: Used to adjust scaling to match the sonar used (only Maxbotix sonars are supported at this time)
    // @Values: 0:XL-EZ0 / XL-EZ4,1:LV-EZ0,2:XLL-EZ0,3:HRLV
    // @User: Standard
    GSCALAR(sonar_type,     "SONAR_TYPE",           AP_RANGEFINDER_MAXSONARXL),

    // @Param: SONAR_GAIN
    // @DisplayName: Sonar gain
    // @Description: Used to adjust the speed with which the target altitude is changed when objects are sensed below the copter
    // @Range: 0.01 2.0
    // @Increment: 0.01
    // @User: Standard
    GSCALAR(sonar_gain,     "SONAR_GAIN",           SONAR_GAIN_DEFAULT),

    // @Param: FS_BATT_ENABLE
    // @DisplayName: Battery Failsafe Enable
    // @Description: Controls whether failsafe will be invoked when battery voltage or current runs low
    // @Values: 0:Disabled,1:Land,2:RTL
    // @User: Standard
    GSCALAR(failsafe_battery_enabled, "FS_BATT_ENABLE", FS_BATT_DISABLED),

    // @Param: FS_BATT_VOLTAGE
    // @DisplayName: Failsafe battery voltage
    // @Description: Battery voltage to trigger failsafe. Set to 0 to disable battery voltage failsafe. If the battery voltage drops below this voltage then the copter will RTL
    // @Units: Volts
    // @Increment: 0.1
    // @User: Standard
    GSCALAR(fs_batt_voltage,        "FS_BATT_VOLTAGE", FS_BATT_VOLTAGE_DEFAULT),

    // @Param: FS_BATT_MAH
    // @DisplayName: Failsafe battery milliAmpHours
    // @Description: Battery capacity remaining to trigger failsafe. Set to 0 to disable battery remaining failsafe. If the battery remaining drops below this level then the copter will RTL
    // @Units: mAh
    // @Increment: 50
    // @User: Standard
    GSCALAR(fs_batt_mah,            "FS_BATT_MAH", FS_BATT_MAH_DEFAULT),

    // @Param: FS_GPS_ENABLE
    // @DisplayName: GPS Failsafe Enable
    // @Description: Controls what action will be taken if GPS signal is lost for at least 5 seconds
    // @Values: 0:Disabled,1:Land,2:AltHold,3:Land even from Stabilize
    // @User: Standard
    GSCALAR(failsafe_gps_enabled, "FS_GPS_ENABLE", FS_GPS_LAND),

    // @Param: FS_GCS_ENABLE
    // @DisplayName: Ground Station Failsafe Enable
    // @Description: Controls whether failsafe will be invoked (and what action to take) when connection with Ground station is lost for at least 5 seconds
    // @Values: 0:Disabled,1:Enabled always RTL,2:Enabled Continue with Mission in Auto Mode
    // @User: Standard
    GSCALAR(failsafe_gcs, "FS_GCS_ENABLE", FS_GCS_ENABLED_ALWAYS_RTL),

    // @Param: GPS_HDOP_GOOD
    // @DisplayName: GPS Hdop Good
    // @Description: GPS Hdop value at or below this value represent a good position.  Used for pre-arm checks
    // @Range: 100 900
    // @User: Advanced
    GSCALAR(gps_hdop_good, "GPS_HDOP_GOOD", GPS_HDOP_GOOD_DEFAULT),

    // @Param: MAG_ENABLE
    // @DisplayName: Compass enable/disable
    // @Description: Setting this to Enabled(1) will enable the compass. Setting this to Disabled(0) will disable the compass
    // @Values: 0:Disabled,1:Enabled
    // @User: Standard
    GSCALAR(compass_enabled,        "MAG_ENABLE",   MAGNETOMETER),

    // @Param: FLOW_ENABLE
    // @DisplayName: Optical Flow enable/disable
    // @Description: Setting this to Enabled(1) will enable optical flow. Setting this to Disabled(0) will disable optical flow
    // @Values: 0:Disabled,1:Enabled
    // @User: Standard
    GSCALAR(optflow_enabled,        "FLOW_ENABLE",  DISABLED),

    // @Param: SUPER_SIMPLE
    // @DisplayName: Super Simple Mode
    // @Description: Bitmask to enable Super Simple mode for some flight modes. Setting this to Disabled(0) will disable Super Simple Mode
    // @Values: 0:Disabled,1:Mode1,2:Mode2,3:Mode1+2,4:Mode3,5:Mode1+3,6:Mode2+3,7:Mode1+2+3,8:Mode4,9:Mode1+4,10:Mode2+4,11:Mode1+2+4,12:Mode3+4,13:Mode1+3+4,14:Mode2+3+4,15:Mode1+2+3+4,16:Mode5,17:Mode1+5,18:Mode2+5,19:Mode1+2+5,20:Mode3+5,21:Mode1+3+5,22:Mode2+3+5,23:Mode1+2+3+5,24:Mode4+5,25:Mode1+4+5,26:Mode2+4+5,27:Mode1+2+4+5,28:Mode3+4+5,29:Mode1+3+4+5,30:Mode2+3+4+5,31:Mode1+2+3+4+5,32:Mode6,33:Mode1+6,34:Mode2+6,35:Mode1+2+6,36:Mode3+6,37:Mode1+3+6,38:Mode2+3+6,39:Mode1+2+3+6,40:Mode4+6,41:Mode1+4+6,42:Mode2+4+6,43:Mode1+2+4+6,44:Mode3+4+6,45:Mode1+3+4+6,46:Mode2+3+4+6,47:Mode1+2+3+4+6,48:Mode5+6,49:Mode1+5+6,50:Mode2+5+6,51:Mode1+2+5+6,52:Mode3+5+6,53:Mode1+3+5+6,54:Mode2+3+5+6,55:Mode1+2+3+5+6,56:Mode4+5+6,57:Mode1+4+5+6,58:Mode2+4+5+6,59:Mode1+2+4+5+6,60:Mode3+4+5+6,61:Mode1+3+4+5+6,62:Mode2+3+4+5+6,63:Mode1+2+3+4+5+6
    // @User: Standard
    GSCALAR(super_simple,   "SUPER_SIMPLE",     0),

    // @Param: RTL_ALT_FINAL
    // @DisplayName: RTL Final Altitude
    // @Description: This is the altitude the vehicle will move to as the final stage of Returning to Launch or after completing a mission.  Set to zero to land.
    // @Units: Centimeters
    // @Range: -1 1000
    // @Increment: 1
    // @User: Standard
    GSCALAR(rtl_alt_final,  "RTL_ALT_FINAL", RTL_ALT_FINAL),

    // @Param: RSSI_PIN
    // @DisplayName: Receiver RSSI sensing pin
    // @Description: This selects an analog pin for the receiver RSSI voltage. It assumes the voltage is RSSI_RANGE for max rssi, 0V for minimum
    // @Values: -1:Disabled, 0:APM2 A0, 1:APM2 A1, 2:APM2 A2, 13:APM2 A13, 103:Pixhawk SBUS
    // @User: Standard
    GSCALAR(rssi_pin,            "RSSI_PIN",         -1),

    // @Param: RSSI_RANGE
    // @DisplayName: Receiver RSSI voltage range
    // @Description: Receiver RSSI voltage range
    // @Units: Volt
    // @Values: 3.3:3.3V, 5.0:5V
    // @User: Standard
    GSCALAR(rssi_range,          "RSSI_RANGE",         5.0),

    // @Param: WP_YAW_BEHAVIOR
    // @DisplayName: Yaw behaviour during missions
    // @Description: Determines how the autopilot controls the yaw during missions and RTL
    // @Values: 0:Never change yaw, 1:Face next waypoint, 2:Face next waypoint except RTL, 3:Face along GPS course
    // @User: Standard
    GSCALAR(wp_yaw_behavior,  "WP_YAW_BEHAVIOR",    WP_YAW_BEHAVIOR_DEFAULT),

    // @Param: RTL_LOIT_TIME
    // @DisplayName: RTL loiter time
    // @Description: Time (in milliseconds) to loiter above home before begining final descent
    // @Units: ms
    // @Range: 0 60000
    // @Increment: 1000
    // @User: Standard
    GSCALAR(rtl_loiter_time,      "RTL_LOIT_TIME",    RTL_LOITER_TIME),

    // @Param: LAND_SPEED
    // @DisplayName: Land speed
    // @Description: The descent speed for the final stage of landing in cm/s
    // @Units: cm/s
    // @Range: 30 200
    // @Increment: 10
    // @User: Standard
    GSCALAR(land_speed,             "LAND_SPEED",   LAND_SPEED),

    // @Param: PILOT_VELZ_MAX
    // @DisplayName: Pilot maximum vertical speed
    // @Description: The maximum vertical velocity the pilot may request in cm/s
    // @Units: Centimeters/Second
    // @Range: 50 500
    // @Increment: 10
    // @User: Standard
    GSCALAR(pilot_velocity_z_max,     "PILOT_VELZ_MAX",   PILOT_VELZ_MAX),

    // @Param: PILOT_ACCEL_Z
    // @DisplayName: Pilot vertical acceleration
    // @Description: The vertical acceleration used when pilot is controlling the altitude
    // @Units: cm/s/s
    // @Range: 50 500
    // @Increment: 10
    // @User: Standard
    GSCALAR(pilot_accel_z,  "PILOT_ACCEL_Z",    PILOT_ACCEL_Z_DEFAULT),

    // @Param: THR_MIN
    // @DisplayName: Throttle Minimum
    // @Description: The minimum throttle that will be sent to the motors to keep them spinning
    // @Units: Percent*10
    // @Range: 0 300
    // @Increment: 1
    // @User: Standard
    GSCALAR(throttle_min,   "THR_MIN",          THR_MIN_DEFAULT),

    // @Param: THR_MAX
    // @DisplayName: Throttle Maximum
    // @Description: The maximum throttle that will be sent to the motors.  This should normally be left as 1000.
    // @Units: Percent*10
    // @Range: 800 1000
    // @Increment: 1
    // @User: Advanced
    GSCALAR(throttle_max,   "THR_MAX",          THR_MAX_DEFAULT),

    // @Param: FS_THR_ENABLE
    // @DisplayName: Throttle Failsafe Enable
    // @Description: The throttle failsafe allows you to configure a software failsafe activated by a setting on the throttle input channel
    // @Values: 0:Disabled,1:Enabled always RTL,2:Enabled Continue with Mission in Auto Mode,3:Enabled always LAND
    // @User: Standard
    GSCALAR(failsafe_throttle,  "FS_THR_ENABLE",   FS_THR_DISABLED),

    // @Param: FS_THR_VALUE
    // @DisplayName: Throttle Failsafe Value
    // @Description: The PWM level on channel 3 below which throttle sailsafe triggers
    // @Range: 925 1100
    // @Units: pwm
    // @Increment: 1
    // @User: Standard
    GSCALAR(failsafe_throttle_value, "FS_THR_VALUE",      FS_THR_VALUE_DEFAULT),

    // @Param: TRIM_THROTTLE
    // @DisplayName: Throttle Trim
    // @Description: The autopilot's estimate of the throttle required to maintain a level hover.  Calculated automatically from the pilot's throttle input while in stabilize mode
    // @Range: 0 1000
    // @Units: Percent*10
    // @User: Advanced
    GSCALAR(throttle_cruise,        "TRIM_THROTTLE",    THROTTLE_CRUISE),

    // @Param: THR_MID
    // @DisplayName: Throttle Mid Position
    // @Description: The throttle output (0 ~ 1000) when throttle stick is in mid position.  Used to scale the manual throttle so that the mid throttle stick position is close to the throttle required to hover
    // @User: Standard
    // @Range: 300 700
    // @Units: Percent*10
    // @Increment: 1
    GSCALAR(throttle_mid,        "THR_MID",    THR_MID_DEFAULT),

    // @Param: FLTMODE1
    // @DisplayName: Flight Mode 1
    // @Description: Flight mode when Channel 5 pwm is <= 1230
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode1, "FLTMODE1",               FLIGHT_MODE_1),

    // @Param: FLTMODE2
    // @DisplayName: Flight Mode 2
    // @Description: Flight mode when Channel 5 pwm is >1230, <= 1360
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode2, "FLTMODE2",               FLIGHT_MODE_2),

    // @Param: FLTMODE3
    // @DisplayName: Flight Mode 3
    // @Description: Flight mode when Channel 5 pwm is >1360, <= 1490
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode3, "FLTMODE3",               FLIGHT_MODE_3),

    // @Param: FLTMODE4
    // @DisplayName: Flight Mode 4
    // @Description: Flight mode when Channel 5 pwm is >1490, <= 1620
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode4, "FLTMODE4",               FLIGHT_MODE_4),

    // @Param: FLTMODE5
    // @DisplayName: Flight Mode 5
    // @Description: Flight mode when Channel 5 pwm is >1620, <= 1749
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode5, "FLTMODE5",               FLIGHT_MODE_5),

    // @Param: FLTMODE6
    // @DisplayName: Flight Mode 6
    // @Description: Flight mode when Channel 5 pwm is >=1750
    // @Values: 0:Stabilize,1:Acro,2:AltHold,3:Auto,4:Guided,5:Loiter,6:RTL,7:Circle,9:Land,10:OF_Loiter,11:Drift,13:Sport,16:Hybrid
    // @User: Standard
    GSCALAR(flight_mode6, "FLTMODE6",               FLIGHT_MODE_6),

    // @Param: SIMPLE
    // @DisplayName: Simple mode bitmask
    // @Description: Bitmask which holds which flight modes use simple heading mode (eg bit 0 = 1 means Flight Mode 0 uses simple mode)
    // @User: Advanced
    GSCALAR(simple_modes, "SIMPLE",                 0),

    // @Param: LOG_BITMASK
    // @DisplayName: Log bitmask
    // @Description: 2 byte bitmap of log types to enable
    // @Values: 830:Default,894:Default+RCIN,958:Default+IMU,1854:Default+Motors,-6146:NearlyAll,0:Disabled
    // @User: Standard
    GSCALAR(log_bitmask,    "LOG_BITMASK",          DEFAULT_LOG_BITMASK),

    // @Param: ESC
    // @DisplayName: ESC Calibration
    // @Description: Controls whether ArduCopter will enter ESC calibration on the next restart.  Do not adjust this parameter manually.
    // @User: Advanced
    // @Values: 0:Normal Start-up,1:Start-up in ESC Calibration mode
    GSCALAR(esc_calibrate, "ESC",                   0),

    // @Param: TUNE
    // @DisplayName: Channel 6 Tuning
    // @Description: Controls which parameters (normally PID gains) are being tuned with transmitter's channel 6 knob
    // @User: Standard
    // @Values: 0:None,1:Stab Roll/Pitch kP,4:Rate Roll/Pitch kP,5:Rate Roll/Pitch kI,21:Rate Roll/Pitch kD,3:Stab Yaw kP,6:Rate Yaw kP,26:Rate Yaw kD,14:Altitude Hold kP,7:Throttle Rate kP,34:Throttle Accel kP,35:Throttle Accel kI,36:Throttle Accel kD,42:Loiter Speed,12:Loiter Pos kP,22:Loiter Rate kP,28:Loiter Rate kI,23:Loiter Rate kD,10:WP Speed,25:Acro RollPitch kP,40:Acro Yaw kP,9:Relay On/Off,13:Heli Ext Gyro,17:OF Loiter kP,18:OF Loiter kI,19:OF Loiter kD,30:AHRS Yaw kP,31:AHRS kP,32:INAV_TC,38:Declination,39:Circle Rate,41:Sonar Gain
    GSCALAR(radio_tuning, "TUNE",                   0),

    // @Param: TUNE_LOW
    // @DisplayName: Tuning minimum
    // @Description: The minimum value that will be applied to the parameter currently being tuned with the transmitter's channel 6 knob
    // @User: Standard
    // @Range: 0 32767
    GSCALAR(radio_tuning_low, "TUNE_LOW",           0),

    // @Param: TUNE_HIGH
    // @DisplayName: Tuning maximum
    // @Description: The maximum value that will be applied to the parameter currently being tuned with the transmitter's channel 6 knob
    // @User: Standard
    // @Range: 0 32767
    GSCALAR(radio_tuning_high, "TUNE_HIGH",         1000),

    // @Param: FRAME
    // @DisplayName: Frame Orientation (+, X or V)
    // @Description: Controls motor mixing for multicopters.  Not used for Tri or Traditional Helicopters.
    // @Values: 0:Plus, 1:X, 2:V, 3:H, 4:V-Tail, 10:Y6B (New)
    // @User: Standard
    GSCALAR(frame_orientation, "FRAME",             AP_MOTORS_X_FRAME),

    // @Param: CH7_OPT
    // @DisplayName: Channel 7 option
    // @Description: Select which function if performed when CH7 is above 1800 pwm
    // @Values: 0:Do Nothing, 2:Flip, 3:Simple Mode, 4:RTL, 5:Save Trim, 7:Save WP, 8:Multi Mode, 9:Camera Trigger, 10:Sonar, 11:Fence, 12:ResetToArmedYaw, 13:Super Simple Mode, 14:Acro Trainer, 16:Auto, 17:AutoTune, 18:Land, 19:EPM, 20:EKF, 21:Parachute Enable, 22:Parachute Release, 23:Parachute 3pos, 24:Auto Mission Reset
    // @User: Standard
    GSCALAR(ch7_option, "CH7_OPT",                  CH7_OPTION),

    // @Param: CH8_OPT
    // @DisplayName: Channel 8 option
    // @Description: Select which function if performed when CH8 is above 1800 pwm
    // @Values: 0:Do Nothing, 2:Flip, 3:Simple Mode, 4:RTL, 5:Save Trim, 7:Save WP, 8:Multi Mode, 9:Camera Trigger, 10:Sonar, 11:Fence, 12:ResetToArmedYaw, 13:Super Simple Mode, 14:Acro Trainer, 16:Auto, 17:AutoTune, 18:Land, 19:EPM, 20:EKF, 21:Parachute Enable, 22:Parachute Release, 23:Parachute 3pos, 24:Auto Mission Reset
    // @User: Standard
    GSCALAR(ch8_option, "CH8_OPT",                  CH8_OPTION),

    // @Param: ARMING_CHECK
    // @DisplayName: Arming check
    // @Description: Allows enabling or disabling of pre-arming checks of receiver, accelerometer, barometer, compass and GPS
    // @Values: 0:Disabled, 1:Enabled, -3:Skip Baro, -5:Skip Compass, -9:Skip GPS, -17:Skip INS, -33:Skip Parameters, -65:Skip RC, 127:Skip Voltage
    // @User: Standard
    GSCALAR(arming_check, "ARMING_CHECK",           ARMING_CHECK_ALL),

    // @Param: ANGLE_MAX
    // @DisplayName: Angle Max
    // @Description: Maximum lean angle in all flight modes
    // @Range 1000 8000
    // @User: Advanced
    ASCALAR(angle_max, "ANGLE_MAX",                 DEFAULT_ANGLE_MAX),

    // @Param: RC_FEEL_RP
    // @DisplayName: RC Feel Roll/Pitch
    // @Description: RC feel for roll/pitch which controls vehicle response to user input with 0 being extremely soft and 100 being crisp
    // @Range: 0 100
    // @Increment: 1
    // @User: Standard
    // @Values: 0:Very Soft, 25:Soft, 50:Medium, 75:Crisp, 100:Very Crisp
    GSCALAR(rc_feel_rp, "RC_FEEL_RP",  RC_FEEL_RP_VERY_CRISP),

#if HYBRID_ENABLED == ENABLED
    // @Param: HYBR_BRAKE_RATE
    // @DisplayName: Hybrid braking rate
    // @Description: hybrid flight mode's rotation rate during braking in deg/sec
    // @Range: 4 12
    // @User: Advanced
    GSCALAR(hybrid_brake_rate, "HYBR_BRAKE_RATE",  HYBRID_BRAKE_RATE_DEFAULT),

    // @Param: HYBR_BRAKE_ANGLE
    // @DisplayName: Hybrid braking angle max
    // @Description: hybrid flight mode's max lean angle during braking in centi-degrees
    // @Units: Centi-degrees
    // @Range: 2000 4500
    // @User: Advanced
    GSCALAR(hybrid_brake_angle_max, "HYBR_BRAKE_ANGLE",  HYBRID_BRAKE_ANGLE_DEFAULT),
#endif

#if FRAME_CONFIG ==     HELI_FRAME
    // @Group: HS1_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(heli_servo_1,    "HS1_", RC_Channel),
    // @Group: HS2_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(heli_servo_2,    "HS2_", RC_Channel),
    // @Group: HS3_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(heli_servo_3,    "HS3_", RC_Channel),
    // @Group: HS4_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(heli_servo_4,    "HS4_", RC_Channel),

    // @Param: H_STAB_COL_MIN
    // @DisplayName: Heli Stabilize Throttle Collective Minimum
    // @Description: Helicopter's minimum collective position while pilot directly controls collective in stabilize mode
    // @Range: 0 500
    // @Units: Percent*10
    // @Increment: 1
    // @User: Standard
    GSCALAR(heli_stab_col_min, "H_STAB_COL_MIN", HELI_STAB_COLLECTIVE_MIN_DEFAULT),

    // @Param: H_STAB_COL_MAX
    // @DisplayName: Stabilize Throttle Maximum
    // @Description: Helicopter's maximum collective position while pilot directly controls collective in stabilize mode
    // @Range: 500 1000
    // @Units: Percent*10
    // @Increment: 1
    // @User: Standard
    GSCALAR(heli_stab_col_max, "H_STAB_COL_MAX", HELI_STAB_COLLECTIVE_MAX_DEFAULT),
#endif

    // RC channel
    //-----------
    // @Group: RC1_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(rc_1,    "RC1_", RC_Channel),
    // @Group: RC2_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(rc_2,    "RC2_", RC_Channel),
    // @Group: RC3_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(rc_3,    "RC3_", RC_Channel),
    // @Group: RC4_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(rc_4,    "RC4_", RC_Channel),
    // @Group: RC5_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_5,    "RC5_", RC_Channel_aux),
    // @Group: RC6_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_6,    "RC6_", RC_Channel_aux),
    // @Group: RC7_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_7,    "RC7_", RC_Channel_aux),
    // @Group: RC8_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_8,    "RC8_", RC_Channel_aux),

#if CONFIG_HAL_BOARD == HAL_BOARD_PX4 || CONFIG_HAL_BOARD == HAL_BOARD_VRBRAIN
    // @Group: RC9_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_9,                    "RC9_", RC_Channel_aux),
#endif

    // @Group: RC10_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_10,                    "RC10_", RC_Channel_aux),
    // @Group: RC11_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_11,                    "RC11_", RC_Channel_aux),

#if CONFIG_HAL_BOARD == HAL_BOARD_PX4 || CONFIG_HAL_BOARD == HAL_BOARD_VRBRAIN
    // @Group: RC12_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_12,                   "RC12_", RC_Channel_aux),

    // @Group: RC13_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_13,                   "RC13_", RC_Channel_aux),

    // @Group: RC14_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp,../libraries/RC_Channel/RC_Channel_aux.cpp
    GGROUP(rc_14,                   "RC14_", RC_Channel_aux),
#endif

    // @Param: RC_SPEED
    // @DisplayName: ESC Update Speed
    // @Description: This is the speed in Hertz that your ESCs will receive updates
    // @Units: Hz
    // @Range: 50 490
    // @Increment: 1
    // @User: Advanced
    GSCALAR(rc_speed, "RC_SPEED",              RC_FAST_SPEED),

    // @Param: ACRO_RP_P
    // @DisplayName: Acro Roll and Pitch P gain
    // @Description: Converts pilot roll and pitch into a desired rate of rotation in ACRO and SPORT mode.  Higher values mean faster rate of rotation.
    // @Range: 1 10
    // @User: Standard
    GSCALAR(acro_rp_p,                 "ACRO_RP_P",           ACRO_RP_P),

    // @Param: ACRO_YAW_P
    // @DisplayName: Acro Yaw P gain
    // @Description: Converts pilot yaw input into a desired rate of rotation in ACRO, Stabilize and SPORT modes.  Higher values mean faster rate of rotation.
    // @Range: 1 10
    // @User: Standard
    GSCALAR(acro_yaw_p,                 "ACRO_YAW_P",           ACRO_YAW_P),

    // @Param: ACRO_BAL_ROLL
    // @DisplayName: Acro Balance Roll
    // @Description: rate at which roll angle returns to level in acro mode
    // @Range: 0 3
    // @Increment: 0.1
    // @User: Advanced
    GSCALAR(acro_balance_roll,      "ACRO_BAL_ROLL",    ACRO_BALANCE_ROLL),

    // @Param: ACRO_BAL_PITCH
    // @DisplayName: Acro Balance Pitch
    // @Description: rate at which pitch angle returns to level in acro mode
    // @Range: 0 3
    // @Increment: 0.1
    // @User: Advanced
    GSCALAR(acro_balance_pitch,     "ACRO_BAL_PITCH",   ACRO_BALANCE_PITCH),

    // @Param: ACRO_TRAINER
    // @DisplayName: Acro Trainer
    // @Description: Type of trainer used in acro mode
    // @Values: 0:Disabled,1:Leveling,2:Leveling and Limited
    // @User: Advanced
    GSCALAR(acro_trainer,   "ACRO_TRAINER",     ACRO_TRAINER_LIMITED),

    // PID controller
    //---------------
    // @Param: RATE_RLL_P
    // @DisplayName: Roll axis rate controller P gain
    // @Description: Roll axis rate controller P gain.  Converts the difference between desired roll rate and actual roll rate into a motor speed output
    // @Range: 0.08 0.20
    // @Increment: 0.005
    // @User: Standard

    // @Param: RATE_RLL_I
    // @DisplayName: Roll axis rate controller I gain
    // @Description: Roll axis rate controller I gain.  Corrects long-term difference in desired roll rate vs actual roll rate
    // @Range: 0.01 0.5
    // @Increment: 0.01
    // @User: Standard

    // @Param: RATE_RLL_IMAX
    // @DisplayName: Roll axis rate controller I gain maximum
    // @Description: Roll axis rate controller I gain maximum.  Constrains the maximum motor output that the I gain will output
    // @Range: 0 500
    // @Increment: 10
    // @Units: Percent*10
    // @User: Standard

    // @Param: RATE_RLL_D
    // @DisplayName: Roll axis rate controller D gain
    // @Description: Roll axis rate controller D gain.  Compensates for short-term change in desired roll rate vs actual roll rate
    // @Range: 0.001 0.02
    // @Increment: 0.001
    // @User: Standard
    GGROUP(pid_rate_roll,     "RATE_RLL_", AC_PID),

    // @Param: RATE_PIT_P
    // @DisplayName: Pitch axis rate controller P gain
    // @Description: Pitch axis rate controller P gain.  Converts the difference between desired pitch rate and actual pitch rate into a motor speed output
    // @Range: 0.08 0.20
    // @Increment: 0.005
    // @User: Standard

    // @Param: RATE_PIT_I
    // @DisplayName: Pitch axis rate controller I gain
    // @Description: Pitch axis rate controller I gain.  Corrects long-term difference in desired pitch rate vs actual pitch rate
    // @Range: 0.01 0.5
    // @Increment: 0.01
    // @User: Standard

    // @Param: RATE_PIT_IMAX
    // @DisplayName: Pitch axis rate controller I gain maximum
    // @Description: Pitch axis rate controller I gain maximum.  Constrains the maximum motor output that the I gain will output
    // @Range: 0 500
    // @Increment: 10
    // @Units: Percent*10
    // @User: Standard

    // @Param: RATE_PIT_D
    // @DisplayName: Pitch axis rate controller D gain
    // @Description: Pitch axis rate controller D gain.  Compensates for short-term change in desired pitch rate vs actual pitch rate
    // @Range: 0.001 0.02
    // @Increment: 0.001
    // @User: Standard
    GGROUP(pid_rate_pitch,    "RATE_PIT_", AC_PID),

    // @Param: RATE_YAW_P
    // @DisplayName: Yaw axis rate controller P gain
    // @Description: Yaw axis rate controller P gain.  Converts the difference between desired yaw rate and actual yaw rate into a motor speed output
    // @Range: 0.150 0.250
    // @Increment: 0.005
    // @User: Standard

    // @Param: RATE_YAW_I
    // @DisplayName: Yaw axis rate controller I gain
    // @Description: Yaw axis rate controller I gain.  Corrects long-term difference in desired yaw rate vs actual yaw rate
    // @Range: 0.010 0.020
    // @Increment: 0.01
    // @User: Standard

    // @Param: RATE_YAW_IMAX
    // @DisplayName: Yaw axis rate controller I gain maximum
    // @Description: Yaw axis rate controller I gain maximum.  Constrains the maximum motor output that the I gain will output
    // @Range: 0 800
    // @Increment: 10
    // @Units: Percent*10
    // @User: Standard

    // @Param: RATE_YAW_D
    // @DisplayName: Yaw axis rate controller D gain
    // @Description: Yaw axis rate controller D gain.  Compensates for short-term change in desired yaw rate vs actual yaw rate
    // @Range: 0.000 0.02
    // @Increment: 0.001
    // @User: Standard
    GGROUP(pid_rate_yaw,      "RATE_YAW_", AC_PID),

    // @Param: LOITER_LAT_P
    // @DisplayName: Loiter latitude rate controller P gain
    // @Description: Loiter latitude rate controller P gain.  Converts the difference between desired speed and actual speed into a lean angle in the latitude direction
    // @Range: 0.1 6.0
    // @Increment: 0.1
    // @User: Advanced

    // @Param: LOITER_LAT_I
    // @DisplayName: Loiter latitude rate controller I gain
    // @Description: Loiter latitude rate controller I gain.  Corrects long-term difference in desired speed and actual speed in the latitude direction
    // @Range: 0.02 1.00
    // @Increment: 0.01
    // @User: Advanced

    // @Param: LOITER_LAT_IMAX
    // @DisplayName: Loiter rate controller I gain maximum
    // @Description: Loiter rate controller I gain maximum.  Constrains the lean angle that the I gain will output
    // @Range: 0 4500
    // @Increment: 10
    // @Units: Centi-Degrees
    // @User: Advanced

    // @Param: LOITER_LAT_D
    // @DisplayName: Loiter latitude rate controller D gain
    // @Description: Loiter latitude rate controller D gain.  Compensates for short-term change in desired speed vs actual speed
    // @Range: 0.0 0.6
    // @Increment: 0.01
    // @User: Advanced
    GGROUP(pid_loiter_rate_lat,      "LOITER_LAT_",  AC_PID),

    // @Param: LOITER_LON_P
    // @DisplayName: Loiter longitude rate controller P gain
    // @Description: Loiter longitude rate controller P gain.  Converts the difference between desired speed and actual speed into a lean angle in the longitude direction
    // @Range: 0.1 6.0
    // @Increment: 0.1
    // @User: Advanced

    // @Param: LOITER_LON_I
    // @DisplayName: Loiter longitude rate controller I gain
    // @Description: Loiter longitude rate controller I gain.  Corrects long-term difference in desired speed and actual speed in the longitude direction
    // @Range: 0.02 1.00
    // @Increment: 0.01
    // @User: Advanced

    // @Param: LOITER_LON_IMAX
    // @DisplayName: Loiter longitude rate controller I gain maximum
    // @Description: Loiter longitude rate controller I gain maximum.  Constrains the lean angle that the I gain will output
    // @Range: 0 4500
    // @Increment: 10
    // @Units: Centi-Degrees
    // @User: Advanced

    // @Param: LOITER_LON_D
    // @DisplayName: Loiter longituderate controller D gain
    // @Description: Loiter longitude rate controller D gain.  Compensates for short-term change in desired speed vs actual speed
    // @Range: 0.0 0.6
    // @Increment: 0.01
    // @User: Advanced
    GGROUP(pid_loiter_rate_lon,      "LOITER_LON_",  AC_PID),

    // @Param: THR_RATE_P
    // @DisplayName: Throttle rate controller P gain
    // @Description: Throttle rate controller P gain.  Converts the difference between desired vertical speed and actual speed into a desired acceleration that is passed to the throttle acceleration controller
    // @Range: 1.000 8.000
    // @User: Standard

    // @Param: THR_RATE_I
    // @DisplayName: Throttle rate controller I gain
    // @Description: Throttle rate controller I gain.  Corrects long-term difference in desired vertical speed and actual speed
    // @Range: 0.000 0.100
    // @User: Standard

    // @Param: THR_RATE_IMAX
    // @DisplayName: Throttle rate controller I gain maximum
    // @Description: Throttle rate controller I gain maximum.  Constrains the desired acceleration that the I gain will generate
    // @Range: 0 500
    // @Units: cm/s/s
    // @User: Standard

    // @Param: THR_RATE_D
    // @DisplayName: Throttle rate controller D gain
    // @Description: Throttle rate controller D gain.  Compensates for short-term change in desired vertical speed vs actual speed
    // @Range: 0.000 0.400
    // @User: Standard
    GGROUP(p_throttle_rate, "THR_RATE_", AC_P),

    // @Param: THR_ACCEL_P
    // @DisplayName: Throttle acceleration controller P gain
    // @Description: Throttle acceleration controller P gain.  Converts the difference between desired vertical acceleration and actual acceleration into a motor output
    // @Range: 0.500 1.500
    // @User: Standard

    // @Param: THR_ACCEL_I
    // @DisplayName: Throttle acceleration controller I gain
    // @Description: Throttle acceleration controller I gain.  Corrects long-term difference in desired vertical acceleration and actual acceleration
    // @Range: 0.000 3.000
    // @User: Standard

    // @Param: THR_ACCEL_IMAX
    // @DisplayName: Throttle acceleration controller I gain maximum
    // @Description: Throttle acceleration controller I gain maximum.  Constrains the maximum pwm that the I term will generate
    // @Range: 0 500
    // @Units: Percent*10
    // @User: Standard

    // @Param: THR_ACCEL_D
    // @DisplayName: Throttle acceleration controller D gain
    // @Description: Throttle acceleration controller D gain.  Compensates for short-term change in desired vertical acceleration vs actual acceleration
    // @Range: 0.000 0.400
    // @User: Standard
    GGROUP(pid_throttle_accel,"THR_ACCEL_", AC_PID),

    // @Param: OF_RLL_P
    // @DisplayName: Optical Flow based loiter controller roll axis P gain
    // @Description: Optical Flow based loiter controller roll axis P gain.  Converts the position error from the target point to a roll angle
    // @Range: 2.000 3.000
    // @User: Standard

    // @Param: OF_RLL_I
    // @DisplayName: Optical Flow based loiter controller roll axis I gain
    // @Description: Optical Flow based loiter controller roll axis I gain.  Corrects long-term position error by more persistently rolling left or right
    // @Range: 0.250 0.750
    // @User: Standard

    // @Param: OF_RLL_IMAX
    // @DisplayName: Optical Flow based loiter controller roll axis I gain maximum
    // @Description: Optical Flow based loiter controller roll axis I gain maximum.  Constrains the maximum roll angle that the I term will generate
    // @Range: 0 4500
    // @Units: Centi-Degrees
    // @User: Standard

    // @Param: OF_RLL_D
    // @DisplayName: Optical Flow based loiter controller roll axis D gain
    // @Description: Optical Flow based loiter controller roll axis D gain.  Compensates for short-term change in speed in the roll direction
    // @Range: 0.100 0.140
    // @User: Standard
    GGROUP(pid_optflow_roll,  "OF_RLL_",   AC_PID),

    // @Param: OF_PIT_P
    // @DisplayName: Optical Flow based loiter controller pitch axis P gain
    // @Description: Optical Flow based loiter controller pitch axis P gain.  Converts the position error from the target point to a pitch angle
    // @Range: 2.000 3.000
    // @User: Standard

    // @Param: OF_PIT_I
    // @DisplayName: Optical Flow based loiter controller pitch axis I gain
    // @Description: Optical Flow based loiter controller pitch axis I gain.  Corrects long-term position error by more persistently pitching left or right
    // @Range: 0.250 0.750
    // @User: Standard

    // @Param: OF_PIT_IMAX
    // @DisplayName: Optical Flow based loiter controller pitch axis I gain maximum
    // @Description: Optical Flow based loiter controller pitch axis I gain maximum.  Constrains the maximum pitch angle that the I term will generate
    // @Range: 0 4500
    // @Units: Centi-Degrees
    // @User: Standard

    // @Param: OF_PIT_D
    // @DisplayName: Optical Flow based loiter controller pitch axis D gain
    // @Description: Optical Flow based loiter controller pitch axis D gain.  Compensates for short-term change in speed in the pitch direction
    // @Range: 0.100 0.140
    // @User: Standard
    GGROUP(pid_optflow_pitch, "OF_PIT_",   AC_PID),

    // PI controller
    //--------------
    // @Param: STB_RLL_P
    // @DisplayName: Roll axis stabilize controller P gain
    // @Description: Roll axis stabilize (i.e. angle) controller P gain.  Converts the error between the desired roll angle and actual angle to a desired roll rate
    // @Range: 3.000 12.000
    // @User: Standard

    // @Param: STB_RLL_I
    // @DisplayName: Roll axis stabilize controller I gain
    // @Description: Roll axis stabilize (i.e. angle) controller I gain.  Corrects for longer-term difference in desired roll angle and actual angle
    // @Range: 0.000 0.100
    // @User: Standard

    // @Param: STB_RLL_IMAX
    // @DisplayName: Roll axis stabilize controller I gain maximum
    // @Description: Roll axis stabilize (i.e. angle) controller I gain maximum.  Constrains the maximum roll rate that the I term will generate
    // @Range: 0 4500
    // @Units: Centi-Degrees/Sec
    // @User: Standard
    GGROUP(p_stabilize_roll,       "STB_RLL_", AC_P),

    // @Param: STB_PIT_P
    // @DisplayName: Pitch axis stabilize controller P gain
    // @Description: Pitch axis stabilize (i.e. angle) controller P gain.  Converts the error between the desired pitch angle and actual angle to a desired pitch rate
    // @Range: 3.000 12.000
    // @User: Standard
    GGROUP(p_stabilize_pitch,      "STB_PIT_", AC_P),

    // @Param: STB_YAW_P
    // @DisplayName: Yaw axis stabilize controller P gain
    // @Description: Yaw axis stabilize (i.e. angle) controller P gain.  Converts the error between the desired yaw angle and actual angle to a desired yaw rate
    // @Range: 3.000 6.000
    // @User: Standard
    GGROUP(p_stabilize_yaw,        "STB_YAW_", AC_P),

    // @Param: THR_ALT_P
    // @DisplayName: Altitude controller P gain
    // @Description: Altitude controller P gain.  Converts the difference between the desired altitude and actual altitude into a climb or descent rate which is passed to the throttle rate controller
    // @Range: 1.000 3.000
    // @User: Standard
    GGROUP(p_alt_hold,     "THR_ALT_", AC_P),

    // @Param: HLD_LAT_P
    // @DisplayName: Loiter position controller P gain
    // @Description: Loiter position controller P gain.  Converts the distance (in the latitude direction) to the target location into a desired speed which is then passed to the loiter latitude rate controller
    // @Range: 0.500 2.000
    // @User: Standard
    GGROUP(p_loiter_pos, "HLD_LAT_", AC_P),

    // variables not in the g class which contain EEPROM saved variables

#if CAMERA == ENABLED
    // @Group: CAM_
    // @Path: ../libraries/AP_Camera/AP_Camera.cpp
    GOBJECT(camera,           "CAM_", AP_Camera),
#endif

    // @Group: RELAY_
    // @Path: ../libraries/AP_Relay/AP_Relay.cpp
    GOBJECT(relay,                  "RELAY_", AP_Relay),

#if EPM_ENABLED == ENABLED
	// @Group: EPM_
    // @Path: ../libraries/AP_EPM/AP_EPM.cpp
    GOBJECT(epm,            "EPM_", AP_EPM),
#endif

#if PARACHUTE == ENABLED
	// @Group: CHUTE_
    // @Path: ../libraries/AP_Parachute/AP_Parachute.cpp
    GOBJECT(parachute,		"CHUTE_", AP_Parachute),
#endif

    // @Group: COMPASS_
    // @Path: ../libraries/AP_Compass/Compass.cpp
    GOBJECT(compass,        "COMPASS_", Compass),

    // @Group: INS_
    // @Path: ../libraries/AP_InertialSensor/AP_InertialSensor.cpp
    GOBJECT(ins,            "INS_", AP_InertialSensor),

    // @Group: INAV_
    // @Path: ../libraries/AP_InertialNav/AP_InertialNav.cpp
    GOBJECT(inertial_nav,           "INAV_",    AP_InertialNav),

    // @Group: WPNAV_
    // @Path: ../libraries/AC_WPNav/AC_WPNav.cpp
    GOBJECT(wp_nav, "WPNAV_",       AC_WPNav),

    // @Group: CIRCLE_
    // @Path: ../libraries/AC_WPNav/AC_Circle.cpp
    GOBJECT(circle_nav, "CIRCLE_",  AC_Circle),

#if FRAME_CONFIG == HELI_FRAME
    // @Group: ATC_
    // @Path: ../libraries/AC_AttitudeControl/AC_AttitudeControl_Heli.cpp
    GOBJECT(attitude_control, "ATC_", AC_AttitudeControl_Heli),
#else
    // @Group: ATC_
    // @Path: ../libraries/AC_AttitudeControl/AC_AttitudeControl.cpp
    GOBJECT(attitude_control, "ATC_", AC_AttitudeControl),
#endif

    // @Group: POSCON_
    // @Path: ../libraries/AC_AttitudeControl/AC_PosControl.cpp
    GOBJECT(pos_control, "POSCON_", AC_PosControl),

    // @Group: SR0_
    // @Path: GCS_Mavlink.pde
    GOBJECTN(gcs[0],  gcs0,       "SR0_",     GCS_MAVLINK),

    // @Group: SR1_
    // @Path: GCS_Mavlink.pde
    GOBJECTN(gcs[1],  gcs1,       "SR1_",     GCS_MAVLINK),

#if MAVLINK_COMM_NUM_BUFFERS > 2
    // @Group: SR2_
    // @Path: GCS_Mavlink.pde
    GOBJECTN(gcs[2],  gcs2,       "SR2_",     GCS_MAVLINK),
#endif

    // @Group: AHRS_
    // @Path: ../libraries/AP_AHRS/AP_AHRS.cpp
    GOBJECT(ahrs,                   "AHRS_",    AP_AHRS),

#if MOUNT == ENABLED
    // @Group: MNT_
    // @Path: ../libraries/AP_Mount/AP_Mount.cpp
    GOBJECT(camera_mount,           "MNT_", AP_Mount),
#endif

#if MOUNT2 == ENABLED
    // @Group: MNT2_
    // @Path: ../libraries/AP_Mount/AP_Mount.cpp
    GOBJECT(camera_mount2,           "MNT2_",       AP_Mount),
#endif

    // @Group: BATT_
    // @Path: ../libraries/AP_BattMonitor/AP_BattMonitor.cpp
    GOBJECT(battery,                "BATT_",       AP_BattMonitor),

    // @Group: BRD_
    // @Path: ../libraries/AP_BoardConfig/AP_BoardConfig.cpp
    GOBJECT(BoardConfig,            "BRD_",       AP_BoardConfig),    

#if SPRAYER == ENABLED
    // @Group: SPRAY_
    // @Path: ../libraries/AC_Sprayer/AC_Sprayer.cpp
    GOBJECT(sprayer,                "SPRAY_",       AC_Sprayer),
#endif

#if CONFIG_HAL_BOARD == HAL_BOARD_AVR_SITL
    GOBJECT(sitl, "SIM_", SITL),
#endif

    // @Group: GND_
    // @Path: ../libraries/AP_Baro/AP_Baro.cpp
    GOBJECT(barometer, "GND_", AP_Baro),

    // GPS driver
    // @Group: GPS_
    // @Path: ../libraries/AP_GPS/AP_GPS.cpp
    GOBJECT(gps, "GPS_", AP_GPS),

    // @Group: SCHED_
    // @Path: ../libraries/AP_Scheduler/AP_Scheduler.cpp
    GOBJECT(scheduler, "SCHED_", AP_Scheduler),

#if AC_FENCE == ENABLED
    // @Group: FENCE_
    // @Path: ../libraries/AC_Fence/AC_Fence.cpp
    GOBJECT(fence,      "FENCE_",   AC_Fence),
#endif

#if AC_RALLY == ENABLED
    // @Group: RALLY_
    // @Path: ../libraries/AP_Rally/AP_Rally.cpp
    GOBJECT(rally,      "RALLY_",   AP_Rally),
#endif

    // @Group: GPSGLITCH_
    // @Path: ../libraries/AP_GPS/AP_GPS_Glitch.cpp
    GOBJECT(gps_glitch,      "GPSGLITCH_",   GPS_Glitch),

#if FRAME_CONFIG ==     HELI_FRAME
    // @Group: H_
    // @Path: ../libraries/AP_Motors/AP_MotorsHeli.cpp
    GOBJECT(motors, "H_",           AP_MotorsHeli),

#elif FRAME_CONFIG == SINGLE_FRAME
    // @Group: SS1_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_1,    "SS1_", RC_Channel),
    // @Group: SS2_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_2,    "SS2_", RC_Channel),
    // @Group: SS3_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_3,    "SS3_", RC_Channel),
    // @Group: SS4_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_4,    "SS4_", RC_Channel),
    // @Group: MOT_
    // @Path: ../libraries/AP_Motors/AP_MotorsSingle.cpp
    GOBJECT(motors, "MOT_",           AP_MotorsSingle),

#elif FRAME_CONFIG == COAX_FRAME
    // @Group: SS1_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_1,    "SS1_", RC_Channel),
    // @Group: SS2_
    // @Path: ../libraries/RC_Channel/RC_Channel.cpp
    GGROUP(single_servo_2,    "SS2_", RC_Channel),
    // @Group: MOT_
    // @Path: ../libraries/AP_Motors/AP_MotorsCoax.cpp
    GOBJECT(motors, "MOT_",           AP_MotorsCoax),

#else
    // @Group: MOT_
    // @Path: ../libraries/AP_Motors/AP_Motors_Class.cpp
    GOBJECT(motors, "MOT_",         AP_Motors),
#endif

    // @Group: RCMAP_
    // @Path: ../libraries/AP_RCMapper/AP_RCMapper.cpp
    GOBJECT(rcmap, "RCMAP_",        RCMapper),

#if AP_AHRS_NAVEKF_AVAILABLE
    // @Group: EKF_
    // @Path: ../libraries/AP_NavEKF/AP_NavEKF.cpp
    GOBJECTN(ahrs.get_NavEKF(), NavEKF, "EKF_", NavEKF),
#endif

    // @Group: MIS_
    // @Path: ../libraries/AP_Mission/AP_Mission.cpp
    GOBJECT(mission, "MIS_",       AP_Mission),
    
#if PX4FLOW == ENABLED
  GOBJECT(ofPX4, "PX4FLOW_", AC_OpticalFlowPX4),    //nombre inicial parametros
#endif

    AP_VAREND
};

/*
  This is a conversion table from old parameter values to new
  parameter names. The startup code looks for saved values of the old
  parameters and will copy them across to the new parameters if the
  new parameter does not yet have a saved value. It then saves the new
  value.

  Note that this works even if the old parameter has been removed. It
  relies on the old k_param index not being removed

  The second column below is the index in the var_info[] table for the
  old object. This should be zero for top level parameters.
 */
const AP_Param::ConversionInfo conversion_table[] PROGMEM = {
    { Parameters::k_param_battery_monitoring, 0,      AP_PARAM_INT8,  "BATT_MONITOR" },
    { Parameters::k_param_battery_volt_pin,   0,      AP_PARAM_INT8,  "BATT_VOLT_PIN" },
    { Parameters::k_param_battery_curr_pin,   0,      AP_PARAM_INT8,  "BATT_CURR_PIN" },
    { Parameters::k_param_volt_div_ratio,     0,      AP_PARAM_FLOAT, "BATT_VOLT_MULT" },
    { Parameters::k_param_curr_amp_per_volt,  0,      AP_PARAM_FLOAT, "BATT_AMP_PERVOLT" },
    { Parameters::k_param_pack_capacity,      0,      AP_PARAM_INT32, "BATT_CAPACITY" },
};

static void load_parameters(void)
{
    if (!AP_Param::check_var_info()) {
        cliSerial->printf_P(PSTR("Bad var table\n"));        
        hal.scheduler->panic(PSTR("Bad var table"));
    }

    // change the default for the AHRS_GPS_GAIN for ArduCopter
    // if it hasn't been set by the user
    if (!ahrs.gps_gain.load()) {
        ahrs.gps_gain.set_and_save(1.0);
    }
    // disable centrifugal force correction, it will be enabled as part of the arming process
    ahrs.set_correct_centrifugal(false);
    ahrs.set_armed(false);

    // setup different AHRS gains for ArduCopter than the default
    // but allow users to override in their config
    if (!ahrs._kp.load()) {
        ahrs._kp.set_and_save(0.1);
    }
    if (!ahrs._kp_yaw.load()) {
        ahrs._kp_yaw.set_and_save(0.1);
    }

    // setup different Compass learn setting for ArduCopter than the default
    // but allow users to override in their config
    if (!compass._learn.load()) {
        compass._learn.set_and_save(0);
    }

    if (!g.format_version.load() ||
        g.format_version != Parameters::k_format_version) {

        // erase all parameters
        cliSerial->printf_P(PSTR("Firmware change: erasing EEPROM...\n"));
        AP_Param::erase_all();

        // save the current format version
        g.format_version.set_and_save(Parameters::k_format_version);
        cliSerial->println_P(PSTR("done."));
    } else {
        uint32_t before = micros();
        // Load all auto-loaded EEPROM variables
        AP_Param::load_all();
        AP_Param::convert_old_parameters(&conversion_table[0], sizeof(conversion_table)/sizeof(conversion_table[0]));
        cliSerial->printf_P(PSTR("load_all took %luus\n"), micros() - before);
    }
}
