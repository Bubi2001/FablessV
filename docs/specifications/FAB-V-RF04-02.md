# Deliverable Specification: FAB-V-RF04-02 (Wideband Active Mixer)

**Project:** 1 GHz – 2.6 GHz Wideband Active Mixer

**Process Node:** IHP SG13G2 (0.13 µm SiGe BiCMOS)

**Topology:** Double-Balanced Gilbert Cell (HBT-Based)

## 1. Electrical Specifications

The primary design objectives are **Linearity (IIP3)** and **Port Isolation** to minimize measurement errors in the VNA application.

| Parameter | Symbol | Target Value | Notes |
| --- | --- | --- | --- |
| **RF/LO Frequency** | $f_{RF},f_{LO}$ | $1 GHz - 2.6 GHz$ | Bandwidth aligns with Wideband LNA. |
| **IF Frequency** | $f_{IF}$ | $100kHz-100 MHz$ | Homodyne (Zero-IF) operation. DC carries magnitude/phase data. |
| **Conversion Gain** | $G_{conv}$ | $0dB-+5dB $ | Unity to moderate gain target; priority is flatness. |
| **Gain Flatness** | $\Delta G$ | $<1.5dB$ | Across full 1–2.6 GHz RF sweep. |
| **Noise Figure (DSB)** | $NF_{DSB}$ | $<12dB$ | Integrated bandwidth: 10 kHz – 100 MHz. |
| **1/f Corner Frequency** | $f_{corner}$ | $<10kHz$ | Critical for Zero-IF. Requires HBT devices. |
| **Input P1dB** | $IP1dB$ | $>-5dBm$ | Headroom for DUT reflections. |
| **Input IP3** | $IIP3$ | $>+5dBm$ | High linearity to prevent cross-modulation. |
| **LO-RF Isolation** | $ISO_{LO-RF}$ | $>30dB$ | Essential to minimize LO leakage from Test Port. |
| **LO Drive Power** | $P_{LO}$ | $<0dBm$ | Low-power drive requirement for LO buffer. |
| **DC Power** | $P_{DC}$ | $<15mW$ | Nominal bias. |

## 2. Design Architecture & Methodology

### A. Topology Selection: Active Gilbert Cell

* **Active Device:** Heterojunction Bipolar Transistors (HBTs).
* **Rationale:**
    * **Flicker Noise:** HBTs exhibit significantly lower $1/f$ noise corners compared to MOSFETs in this node. Since the IF is at DC, MOSFETs would obscure the signal in flicker noise.
    * **Drive Requirement:** Active mixing requires lower LO drive ($-5dBm$) compared to passive FET mixers ($+10dBm$), reducing power budget for the 2.6 GHz LO driver.

### B. Input Stage (RF Port)

* **Challenge:** Wideband $50\Omega$ matching for the transconductance ($G_m$) stage over 1–2.6 GHz.
* **Architecture:** **Common-Base** or **Micromixer (Class-AB)** input stage.
* **Common-Base:** Offers natural wideband input impedance ($Z_{in}\approx1/g_m$).
* **Biasing:** Target $I_C\approx2mA$ to achieve $1/g_m\approx13\Omega$, using series resistance or feedback to align with $50\Omega$.

### C. Output Stage (IF Port)

* **Signal Type:** Current Mode Output.
* **Interface:** Transimpedance Amplifier (TIA).
* **Requirement:** The mixer output must drive a low-impedance node (virtual ground) to maximize linearity. Voltage swing at the collector nodes modulates $C_{BC}$, degrading linearity; a TIA prevents this.

## 3. Critical Design Considerations

### A. DC Offset Cancellation (Homodyne Architecture)

* **Mechanism:** LO leakage to the RF port reflects off the DUT and self-mixes, creating a static DC offset.
* **Mitigation Strategy:**
    1. **Layout Symmetry:** Strict Common-Centroid layout for the switching quad and input differential pair to minimize inherent offsets.
    2. **Calibration:** Design must accommodate Digital-to-Analog Converter (DAC) current injection at the IF output to nullify static offsets during system calibration.

### B. Isolation

* **LO-RF Leakage:** Dominant source of error in VNAs.
* **Layout:** Physical separation of RF and LO lines, orthogonal routing, and extensive substrate guard rings around the LO ports.

## 4. Post-Layout Verification Requirements

| Parameter | Schematic Sim (Ideal) | Post-Layout Sim (Extracted) | Deviation Allowable |
| --- | --- | --- | --- |
| **Conversion Gain** | $6.5dB$ | $3.2dB$ | Max $3dB$ loss due to parasitics. |
| **Bandwidth (3dB)** | $3.0GHz$ | $2.4GHz$ | Verify input match center frequency. |
| **LO-RF Isolation** | $60dB$ | $35dB$ | Minimum $30dB$ required. |
| **Input IP3** | $+8dBm$ | $+6dBm$ |  |
| **DC Power** | $12mW$ | $12mW$ |  |

### Layout Checks

* **Symmetry:** Visual inspection of the switching quad.
* **Grounding:** Low-inductance ground paths for the RF input stage.
