# ASIC Specification: FAB-V-PHOT05 (4x4 Optical Router)

**Project:** 4x4 Non-Blocking Optical Switch Matrix

**Process Node:** SiEPIC EBeam (Silicon-On-Insulator)

**PDK:** UBC PDK (via `gdsfactory`)

**Topology:** Path-Independent Insertion Loss (PILOSS)

**Operating Band:** C-Band (1550nm)

## 1. Top-Level Specifications

The device is a strictly non-blocking  optical router, allowing any input port to be connected to any output port. The PILOSS topology is selected to ensure deterministic optical power loss across all permutation paths.

| Parameter | Symbol | Target Value | Notes |
| --- | --- | --- | --- |
| **Matrix Size** |  |  | 16 Switching Elements (Intersections). |
| **Operating Wavelength** |  |  | Standard Telecom C-Band. |
| **Insertion Loss (Path)** |  |  | Budget: Coupling () + Propagation (). |
| **Loss Uniformity** |  |  | Variation between best-case and worst-case paths. |
| **Crosstalk** |  |  | Optical leakage into inactive ports. |
| **Switching Speed** |  |  | Limited by thermo-optic time constant. |
| **Total Power Consumption** |  |  | Worst case: All 16 heaters active. |

## 2. Optical I/O (Grating Couplers)

Coupling light between single-mode fiber (SMF-28) and the 220nm silicon waveguide layer.

| Parameter | Specification | Competence Check |
| --- | --- | --- |
| **Coupling Efficiency** |  | Requires optimization of period and fill factor in FDTD (Meep) for . |
| **Bandwidth (1dB)** |  | Must cover full C-Band. |
| **Polarization** | TE Mode Only | Silicon waveguides are highly birefringent; TM modes must be filtered or rejected. |
| **Pitch** |  | Standard Fiber Array (FA) spacing. |

## 3. Switching Element: Thermo-Optic MZI

The core switching unit is a  Mach-Zehnder Interferometer (MZI) utilizing the Thermo-Optic effect () in Silicon.

* **Mechanism:** Resistive Heater (Ti/W) placed above the waveguide arm phase shifts the light.
* : Output = Cross Port (Default state).
* : Output = Bar Port (Switched state).

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Extinction Ratio** |  | Ratio of Power ON / Power OFF. |
| **Switching Power ()** |  | Electrical power required to induce  phase shift. |
| **Heater Resistance** |  | Target for compatibility with standard 5V CMOS drivers. |
| **Coupler Imbalance** |  | Internal directional couplers must be exactly 50:50. |

## 4. Topology Selection: PILOSS

**Rationale:**

* **Standard Crossbar:** Path length varies. Input 1  Output 1 traverses 1 switch; Input 4  Output 4 traverses 7 switches. This creates a 7x dynamic range problem for the receiver.
* **PILOSS (Path-Independent Insertion Loss):**
* **Architecture:** Recursive structure ensuring every I/O path traverses exactly **N (4)** switches and **1** waveguide crossing.
* **Benefit:** Deterministic Insertion Loss simplifies receiver AGC (Automatic Gain Control) and laser power calibration.

## 5. Critical Design Challenges

### A. Thermal Crosstalk

* **Issue:** Heat diffusion from an active switch () spreads through the silicon substrate, unintentionally phase-shifting adjacent switches ().
* **Mitigation:**
1. **Deep Trenches:** Etch "Thermal Air Gaps" around heaters to increase thermal resistance between units.
2. **Floorplanning:** Minimum switch spacing .

### B. Phase Error Calibration

* **Issue:** Nanometer-scale manufacturing variations in waveguide width alter the Effective Index (), causing random phase offsets. The "OFF" state will not be perfectly dark at 0V.
* **Mitigation:**
* **Bias Tuning:** Software calibration routine required at startup. Every MZI must be swept to find its specific  (Zero Point) before operation begins.

### C. Electro-Optical Integration

* **Issue:** Routing 32 electrical tracks (16 heaters  2 pads) without interfering with optical modes.
* **Constraint:** Metal tracks absorb light.
* **Rule:** Metal routing must maintain  separation from any optical waveguide. Design for wirebonding (pad pitch ).

## 6. Verification & Characterization Requirements

| Parameter | Simulated (Lumerical/Sax) | Measured (Lab - Tunable Laser) | Deviation |
| --- | --- | --- | --- |
| **Insertion Loss (Best Path)** |  |  | Coupling loss usually dominates measurement. |
| **Insertion Loss (Worst Path)** |  |  |  |
| **Uniformity** |  |  | Target . |
| **Crosstalk (Worst Case)** |  |  |  |
