# ASIC Specification: FAB-V-ANA02 (Analog BGR & Temp Sensor)

**Project:** Precision Bandgap Reference with Temperature Sensor

**Process Node:** GF180MCU (GlobalFoundries 180nm)

**Design Type:** Fully Analog

## 1. General Operating Conditions

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Supply Voltage ($V_{DD}$)** | 3.0 V – 3.6 V | Nominal: 3.3 V. Device breakdown limit: 5 V. |
| **Temperature Range ($T_{opt}$)** | $-40ºC$ to $+125ºC$ | Industrial Temperature Grade. |
| **Quiescent Current ($I_Q$)** | $<25\mu A?$ | Total consumption including core, buffer, and bias. |
| **Startup Time** | $<20\mu s?$ | Settling time to 0.1% of final $V_{REF}$. |
| **Shutdown Current** | $<100nA?$ | Via active-high ENABLE pin. |

## 2. Bandgap Reference ($V_{REF}$) Specifications

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Output Voltage** | $1.200V$ | Target value after trimming. |
| **Initial Accuracy** | $\pm1.0\%?$ | Post-trim at $27ºC$. |
| **Temperature Coefficient** | $<40\text{ ppm/ºC}?$ | Box Method ($-40ºC$ to $+125ºC$). |
| **Line Regulation** | $<2mV/V?$ | $\Delta V_{REF}/\Delta V_{DD}$ (3.0 V to 3.6 V). |
| **Load Regulation** | $<0.5\%?$ | $\Delta V_{REF}$ for $I_{LOAD}=0$ to $100\mu A$. |
| **PSRR** | $>60 dB (DC)?$ | Power Supply Rejection Ratio. |
|  | $>30 dB (100kHz)?$ | Critical rejection frequency for switching noise. |
| **Output Noise** | $<100\mu V_{RMS}?$ | Integrated Bandwidth: 10 Hz – 100 kHz. |

## 3. Temperature Sensor ($V_{TEMP}$) Specifications

Derived from the internal Proportional To Absolute Temperature (PTAT) current generation core.

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Output Type** | Analog Voltage | Buffered PTAT output. |
| **Sensitivity** | $\approx4mV/ºC?$ | Nominal slope. |
| **Output Range** | $0.6 V$ to $1.4 V$ | Linear operating range across $T_{opt}$. |
| **Linearity Error** | $<0.5ºC?$ | Maximum deviation from best-fit line. |

## 4. Digital Control & Trimming Interface ?

* **Interface Type:** 4-bit Parallel GPIO.
* **Resolution:** 4-bit Binary Weighted.
* **Mechanism:** Adjustment of tail current mirror ratio or resistor ladder taps.
* **Trim Range:** Sufficient to cover $\pm10\%$ process variation.

* **Control Pins:**
* `ENABLE` (Input): Active High. Logic 0 puts block into shutdown ($<100nA$).
* `TRIM[3:0]` (Input): Calibration word.

## 5. Critical Design Architecture Requirements

### A. Startup Circuitry

* **Requirement:** Dedicated startup block to prevent "Zero-Current" meta-stable state.
* **Constraint:** Circuit must automatically disengage once $V_{REF}$ exceeds threshold to prevent leakage from degrading Temperature Coefficient.

### B. Output Buffer Stability - Vamos viendo

* **Topology:** Unity-gain stable Operational Transconductance Amplifier (OTA).
* **Load Condition:** Must remain stable with $C_{LOAD}=1pF$ while sourcing up to $10\mu A$.
* **Compensation:** Internal Miller compensation or dominant pole compensation required.

### C. Noise Optimization

* **Device Sizing:** Input differential pairs and current mirror masters must utilize large $W\times L$ dimensions to minimize $1/f$ (flicker) noise contributions in the 180nm node.
