# Deliverable Specification: FAB-V-RF04-01 (2.4 GHz Narrowband LNA)

**Project:** 2.4 GHz Narrowband Low Noise Amplifier (LNA)

**Process Node:** IHP SG13G2 (0.13 µm SiGe BiCMOS)

**Target Band:** 2.40 GHz – 2.425 GHz (ISM Band)

**Topology:** Single-Ended Cascode with Inductive Degeneration

## 1. Electrical Specifications

| Parameter | Symbol | Target Value | Stretch Goal | Notes |
| --- | --- | --- | --- | --- |
| **Small Signal Gain** | $S_{21}$ | $>15dB$ | $>18dB$ | Single stage cascode. |
| **Noise Figure** | $NF_{min}$ | $<3.0dB$ | $<2.5dB$ | Simultaneous Noise and Impedance match required. |
| **Input Return Loss** | $S_{11}$ | $<-10dB$ | $<-15dB$ |  |
| **Output Return Loss** | $S_{22}$ | $<-10dB$ | $<-15dB$ |  |
| **Reverse Isolation** | $S_{12}$ | $<-20dB$ | $<-30dB$ |  |
| **Input IP3** | $IIP3$ | $>-10dBm$ | $>-5dBm$ | Two-tone test spacing: 1 MHz. |
| **Input P1dB** | $P_{1dB}$ | $>-20dBm$ | $>-15dBm$ |  |
| **Stability Factor** | $K$ | $>1.0$ | Unconditional | Valid across full bandwidth (DC to 100 GHz). |
| **Power Consumption** | $P_{DC}$ | $<15mW$ | $<10mW$ | Nominal bias: 1.5V – 2.0V supply. |

## 2. Design Architecture & Methodology

### A. Circuit Topology

* **Active Device:** High-Speed Heterojunction Bipolar Transistor (HBT) `npn13g2` ($f_T\approx300GHz$).
* **Input Impedance Generation:** Inductive Emitter Degeneration.
* **Implementation:** Transmission Line Stub (Microstrip or Grounded CPW).

* **Biasing:** Active Current Mirror topology to ensure stability across temperature ($-40ºC$ to $+125ºC$).

### B. Matching Networks

* **Input Matching:** High-Q Microstrip Lines (TopMetal2 shielded by TopMetal1 or Substrate) optimized for Noise Figure.
* **Output Matching:** T-network or $\pi$-network for conjugate matching to $50\Omega$.
* **Interconnects:** All interconnects $>\lambda/10$ must be treated as transmission lines.

### C. Electromagnetic (EM) Simulation Flow

1. **Schematic Entry:** Ideal transmission line models in Qucs-S.
2. **Layout:** Physical geometry implementation in KLayout.
3. **EM Extraction:** Full 3D/2.5D EM simulation of passive structures using **OpenEMS**.
4. **Co-Simulation:** S-parameter blocks (Touchstone `.s2p`) imported back into Qucs-S/Ngspice to verify active device performance with physical passives.

## 3. Post-Layout Verification Requirements

Final sign-off requires a comparison between Schematic (Ideal) and EM-Extracted (Physical) performance.

| Parameter | Schematic Sim | Post-Layout EM Sim | Deviation ($\Delta$) |
| --- | --- | --- | --- |
| **Center Frequency ($f_c$)** | xx | xx | Target: <2% shift |
| **Peak Gain ($S_{21}$)** | xx | xx | Target: <1dB drop |
| **Noise Figure ($NF$)** | xx | xx | Target: <0.3B rise |
| **Input Match ($S_{11}$)** | xx | xx |  |

### Design Considerations

* **Frequency Centering:** Target schematic center frequency at $\approx2.45GHz$ to account for parasitic capacitance lowering the frequency in the physical layout.
* **Grounding Inductance:** Emitter ground path requires multiple parallel vias placed as close to the device as possible to minimize gain degradation.
