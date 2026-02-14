# ASIC Specification: FAB-V-MIX03 (Mixed-Signal DPLL & CGU)

**Project:** All-Digital Phase-Locked Loop (ADPLL) with Clock Generation Unit

**Process Node:** SKY130 (130nm CMOS)

**Design Type:** Mixed-Signal (Analog-on-Top Flow)

## 1. Top-Level Specifications

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Input Reference ($f_{ref}$)** | 10 MHz – 40 MHz | Standard Crystal Oscillator (XO) input. |
| **Output Frequency ($f_{out}$)** | 100 MHz – 800 MHz | Wide-range tuning to support logic and RF IF. |
| **Lock Time** | $<50?$ ref cycles | Fast-locking requirement for dynamic frequency scaling. |
| **Power Consumption** | $<10mW$ | Measured at $800 MHz$ output. |
| **Jitter (RMS)** | $<100ps$ | Integrated phase noise (10 kHz – 100 MHz). |
| **Duty Cycle** | $50\%\pm5\%$ | At all output dividers. |

## 2. ADPLL Architecture

### A. Digitally Controlled Oscillator (DCO)

* **Topology:** 3-Stage or 5-Stage Pseudo-Differential Ring Oscillator.
* **Tuning Mechanism:**
    * **Coarse:** Switched Capacitor Bank (Process/Voltage/Temperature calibration).
    * **Fine:** Varactor or Current-Starved Inverter (Digital-to-Analog conversion).
* **Resolution:** Frequency Step ($\Delta f$) $<500kHz/LSB$. Critical for minimizing quantization noise.

### B. Time-to-Digital Converter (TDC)

* **Topology:** Vernier Delay Line.
* **Resolution:** $<50ps$.
* **Method:** Utilization of delay difference ($\Delta t=t_{slow}-t_{fast}$) to achieve sub-gate-delay resolution.
* **Dynamic Range:** $>1\times T_{DCO\_max}$ (Full DCO period coverage).

### C. Digital Loop Filter (DLF)

* **Implementation:** Synthesized Digital Logic (RTL).
* **Control Algorithm:** Proportional-Integral (PI) Controller.
* **Bandwidth:** Programmable (Low BW for jitter attenuation; High BW for fast locking).
* **Dithering:** Required to prevent limit cycles (Dead Zone elimination).

## 3. Clock Generation Unit (CGU)

The DCO output drives a 4-channel clock distribution network.

| Output Channel | Type | Divider Range | Application |
| --- | --- | --- | --- |
| **CLK_OUT_0** | Bypass | $\div1$ | RF Local Oscillator / High-Speed Test. |
| **CLK_OUT_1** | Integer | $\div2$ to $\div255$ | System Clock (CPU). |
| **CLK_OUT_2** | Fractional | $\div N.F$ | Audio/Video Synchronization (e.g., I2S). *Requirement:* Delta-Sigma Modulator (DSM) for fractional division. |
| **CLK_OUT_3** | Low Power | $\div2$ to $\div65535$ | Real-Time Counter / Peripheral Clock. |

## 4. Digital Control Interface

* **Protocol:** SPI Slave (Mode 0, Max 50 MHz).
* **Address Space:** 8-bit Address, 16-bit Data.

**Register Map Summary:**

| Address | Register Name | Bit Field | Function |
| --- | --- | --- | --- |
| `0x00` | `DPLL_CTRL` | `[0]` | **ENABLE**: Global PLL Enable. |
|  |  | `[1]` | **RESET**: Reset Loop Filter accumulator. |
|  |  | `[4]` | **MODE**: 0 = Integer-N, 1 = Fractional-N. |
| `0x04` | `DCO_CFG` | `[7:0]` | **COARSE_TUNE**: Manual capacitor bank override. |
| `0x08` | `DIV_INT` | `[15:0]` | **M_DIV**: Integer Feedback Divider (N). |
| `0x0C` | `DIV_FRAC` | `[15:0]` | **K_DIV**: Fractional Feedback Divider (F). |
| `0x10` | `DLF_KP` | `[15:0]` | **P_GAIN**: Proportional Gain Coefficient. |
| `0x14` | `DLF_KI` | `[15:0]` | **I_GAIN**: Integral Gain Coefficient. |
| `0x20` | `OUT1_DIV` | `[7:0]` | Divider Ratio for `CLK_OUT_1`. |
| `0x24` | `OUT2_DIV` | `[15:0]` | Divider Ratio for `CLK_OUT_2`. |
| `0x30` | `STATUS` | `[0]` | **LOCK_DET**: Lock Detect Status (Read-Only). |

## 5. Implementation & Integration Strategy

### A. Mixed-Signal Flow (Analog-on-Top vs. Digital-on-Top)

* **Custom Cells:** DCO and TDC to be designed and laid out in Magic.
* **Macro Hardening:** Custom cells must be characterized to generate **Liberty (.lib)** and **LEF** files.
* **Digital Integration:** OpenLane flow used to synthesize DLF and Dividers, placing them around the hardened Analog Macros.

### B. Power Integrity & Noise Isolation

* **Power Domains:** Strict separation of Analog Supply ($V_{DD\_ANA}$) and Digital Supply ($V_{DD\_DIG}$).
* **Isolation:** Double guard rings required around the DCO and TDC.
* **Decoupling:** Maximum density MIM capacitor filling in empty layout space.

### C. Phase Noise Mitigation

* **Dead Zone:** TDC resolution must be finer than DCO LSB to prevent limit cycling.
* **Substrate Noise:** Use of deep n-well isolation or physical separation to minimize coupling from High-Speed Dividers to DCO.
