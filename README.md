# Fabless-V: DC to Daylight

> **"From 0 Hz to 193 THz."**
> A monorepo for the design, simulation, and layout of five distinct Application Specific Integrated Circuits (ASICs) covering the entire electromagnetic spectrum: Digital, Analog, Mixed-Signal, RF, and Silicon Photonics.

## Overview

**Fabless-V** is an advanced engineering initiative to master the full vertical stack of silicon design. We treat chip design not as a black-box academic exercise, but as a full-stack engineering discipline.

We utilize a **100% Open Source Toolchain (FOSSi)** running on a unified Dockerized environment (`IIC-OSIC-TOOLS`) on Windows 11 (WSL2), proving that professional-grade silicon design is accessible without million-dollar licenses.

## Repository Structure

This repository acts as a "Super-Lab", isolating specific designs while sharing standard libraries, math models and PDK artifacts

```Plaintext
FablessV/
├── designs/                  # The Silicon Source Code
│   ├── 01_digital_riscv/     # [ASIC 1] RTL, OpenLane Configs, Firmware
│   ├── 02_analog_bgr/        # [ASIC 2] Xschem Schematics, Magic Layouts, CACE Specs
│   ├── 03_mixed_dpll/        # [ASIC 3] Co-simulation bridges (Ngspice <-> Verilog)
│   ├── 04_rf/                # [ASIC 4] OpenEMS Scripts, QucS-S Projects, GDSII
│   └── 05_photonics_onoc/    # [ASIC 5] GDSFactory Scripts, Meep FDTD, Sax Sim
├── tools/                    # External Tool Scripts (OpenFASoC, IHP Extras, SiEPIC)
├── common/                   # Shared Python/Octave Models & Verilog Libs
├── artifacts/                # Heavy Data (PDKs, Sim Waveforms) - Git Ignored
├── docker-compose.yml        # The Lab Configuration
└── setup_extras.sh           # Dependency Installer
```

## Quick Start (Windows 11)

We used a **Dockerized Flow**. You do not need to installtools individually.

### Prerequisites

  1. WSL2 installed (Ubuntu 24.04 recommended).
  2. Docker Desktop installed with WSL2 backend enabled.
  3. VcXsrv (Windows X Server) installed for GUI apps.

### 1. Configure Display (One-time Setup)

Launch XLaunch (VcXsrv) with these settings:

  * Display settings: **Multiple windows**
  * Client startup: **Start no client**
  * Extra settings: **Check "Disable access control"** (Crucial for Docker GUI)

### 2. Clone & Initialize

```bash
# In your WSL2 terminal
git clone https://github.com/Bubi2001/FablessV.git
cd FablessV

# Create artifact directories (to persist PDKs)
mkdir -p artifacts/pdk artifacts/sim_data

# Fetch extra tools (OpenFASoC, IHP Scripts, CACE)
chmod +x setup_extras.sh
./setup_extras.sh
```

### 3. Launch the Lab

```bash
# Spin up the container
docker-compose up -d

# Enter the design environment
docker exec -it fabless_v_lab bash
```

Inside the Lab use the "Swiss Army Knife" (SAK) to select the PDK to use

```bash
# Set the PDK to Google SkyWater 130nm
sak-pdk sky130A

# Set the PDK to GlobalFoundries 180nm MCU
sak-pdk gf180mcuD

# Set the PDK to IHP SG13G2
sak-pdk ihp-sg13g2
```

## The Toolchain

We stand on the shoulders of giants. Our stack includes:

  - **Digital:** OpenLane, OpenROAD, Yosys, Nextpnr, OpenSTA, Verilator, Icarus Verilog, GTKWave, Cocotb.
  - **Analog:** Xschem, Ngspice, Magic (Layout), Netgen (LVS), CACE, OpenFASoC.
  - **RF:** QucS-S, Xyce, OpenEMS (EM Simulation), KLayout, PyEMS, Scikit-rf.
  - **Photonics:** gdsfactory, Meep, Sax, SiEPIC-Tools
  - **Verification:** Cocotb, Volare, Google SkyWater Test Harness, SymbiYosys.
  - **PDKs:** [SKY130](https://github.com/google/skywater-pdk), [GF180MCU](https://github.com/google/gf180mcu-pdk), [IHP SG13G2](https://github.com/IHP-GmbH/IHP-Open-PDK), [SiEPIC EBeam](https://github.com/SiEPIC/SiEPIC_EBeam_PDK)

## Contributing & Review

This is an open educational project. We welcome "Roasts" of our designs!
If you spot an impedance mismatch, a timing violation, or a bad current mirror, please open an Issue.

> *"We do these things not because they are easy, but because we thought they would be easier than they actually are."*

> *"Any sufficiently advanced technology is indistinguishable from magic. We are just trying to learn the spells."*
