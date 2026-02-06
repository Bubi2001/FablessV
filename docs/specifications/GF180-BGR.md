# GF180-BGR

**Status:** Preliminary / Experimental
**Silicon:** GlobalFoundries 180nm MCU (GF180MCU)
**Revision:** 0.1

## 1. General Description

The **GF18-BCR** is a precision CMOS Bandgap Voltage Reference designed using the open-source PDK **GF180MCU**. It provides a stable, temperature-independent reference voltage of **1.2 V (Typical)** suitable for biasing analog circuits, ADCs, and regulators.

Designed for ease of integration in mixed-signal SoCs, this IP block utilizes **Brokaw cell** to achieve high Power Supply Rejection Ratio (PSRR) and low temperature coefficient across the industrial temperature range.

## 2. Features

  * **Process:** GF180MCU
  * **Output Voltage ($V_{REF}$):** 1.20 V (Typ)
  * **Supply Voltage ($V_{DD}$):** 3.3 V to 5.5 V
  * **Temperature Coefficient:** < 60 ppm/ºC
  * **Temperature Range:** -40 ºC to 125 ºC
  * **Quiescent Current:** 15 - 30 $\mu A$
  * **Load Capacitance:** 10 pF - 50 pF
  * **PSRR:** 55 dB @ 1 kHz
  * **Start-up Circuit:** Integrated
  * **Area:** [Width] $\mu m$ x [Height] $\mu m$

## 3. Applications

  * Power Management ICs (LDOs, DC-DC)
  * Analog-to-Digital Converters (ADCs)
  * IoT Sensor Nodes
  * Bias generation for Operational Amplifiers

## 4. Pin Configuration and Functions

| Pin Name | I/O | Description |
|:---:|:---:|:---:|
| VDD | Power | Positive Supply Voltage |
| VSS | Power | Ground Rreference |
