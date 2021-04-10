# My Setup

```
; === My Wilson Settings (MK8 Extuder) ===

; Steps per unit:
; Default: M92 X80.00 Y80.00 Z4000.00 E100.00
; Old setting: M92 E85.00
; M92 E112
; APPLIED IN FIRMWARE - DEFAULT_AXIS_STEPS_PER_UNIT

; Maximum feedrates (mm/s):
; Default: M203 X200.00 Y200.00 Z5.00 E25.00
; M203 X100.00 Y100.00 Z3.00
; APPLIED IN FIRMWARE - DEFAULT_MAX_FEEDRATE

; Advanced variables: S=Min feedrate (mm/s), T=Min travel feedrate (mm/s), B=minimum segment time (ms), X=maximum XY jerk (mm/s),  Z=maximum Z jerk (mm/s),  E=maximum E jerk (mm/s)
; Default: M205 S0.00 T0.00 B20000 X20.00 Y20.00 Z0.40 E5.00
; M205 X10.00 Y10.00
; Not sure this is used with junction deviation enabled?
; Doesn't seem to be set anymore?

; PID settings (Extruder):
; Default: M301 P22.20 I1.08 D114.00
; Run PID tuning (should have fan on): M303 S190 C5
; M301 P24.47 I1.01 D147.84
; APPLIED IN FIRMWARE - DEFAULT_Kp, DEFAULT_Ki, DEFAULT_Kd

; PID settings (Bed)
; Default: M304 P441.29 I54.30 D896.54
; M304 P340.44 I66.60 D435.03
; APPLIED IN FIRMWARE - DEFAULT_bedKp, DEFAULT_bedKi, DEFAULT_bedKd


; Home offset (mm)
; Default: M206 X0.00 Y0.00 Z0.00
; M206 X-14 Y-6
; APPLIED IN FIRMWARE - MANUAL_X_HOME_POS, MANUAL_Y_HOME_POS


; Compact version
; M205 X10.00 Y10.00

; M500 ; Save settings
; M501 ; Reset settings to EEPROM
; M502 ; Reset settings to defaults
; M503 ; Show settings
```


# Scripts

```
; Start Script
M420 S1 Z10 ; Turn bed levelling on with fade
G28 ; Home all axes




; End Script
; Turn everything off
M104 S0 ; Turn off hot end heater
M107 ; Turn off the fans
M140 S0 ; Disable heated bed
; Move everything out the way
G92 E0 ; Reset extruder position
G91 ; Relative positioning
G1 E-1 F1800 ; Retract 1mm
G1 F1000 Z+10 ; Raise off print 10mm
G90 ; Absolute positioning
G1 X0 Y145 F3000 ; Position bed/head nicely
; And, finally...
M84 ; Turn steppers off
```


# Flashing GT2560

* Use the CH403 driver (NOT FTDI!!!)
* USBTiny doesn't work; use USBASP

Pinouts:
* 6-pin: https://www.avrfreaks.net/sites/default/files/avr%20pocket%20programmer%20pinout2.jpg
* 10-pin: http://www.thedelishlife.com/wp-content/uploads/2018/07/usbasp-pinout-10-pin-awesome-vag-vcds-everything-sitemap-page-19-digital-kaos-of-usbasp-pinout-10-pin.jpg
* GT2560: http://www.geeetech.com/forum/download/file.php?id=1656

Black-Gnd
White-MOSI
Grey-5v
Green-Rst
Blue-Sck
Purple-MISO


# Heatbed

Bed - MK1, 214mm x 214mm
Glass - 200mm x 200mm
Screws - 3mm diameter, center is 3mm from edge (4mm from glass)


# Screen

EXP1 = LCD
EXP2 = SD

One end of the cables needs to be reversed!


# Motors

* A4988 Drivers
* Driver pot goes away from the edge of the mainboard
* [Zapp SY42STH47-1684B](https://www.zappautomation.co.uk/sy42sth47-1684b-high-torque-hybrid-stepper-motors.html)
** 1.8 degrees, 2.8v, 1.68A
* Tuning:
** **HAVE YOU APPLIED YOUR SETTINGS YET???**
** https://matterhackers.dozuki.com/Guide/Tuning+Motor+Current/37
** Current Limit = VREF × 2.5
** VREF (EXY) = 1.68 / 2.5 = 0.67v
** VREF (Z) = 2 * 1.68 / 2.5 = 1.34v
