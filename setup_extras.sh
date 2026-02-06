#!/bin/bash
# Enter the tools directory
cd tools

echo "Installing Extra Tools..."

# 1. OpenFASoC (Analog Generation)
git clone https://github.com/idea-fasoc/OpenFASoC.git

# 2. Google SkyWater Test Harness
git clone https://github.com/google/skywater-pdk-libs-sky130_fd_pr.git

# 3. Volker Mühlhaus' OpenEMS Scripts (IHP)
# Note: Volker often updates these. We clone the specific IHP OpenEMS workflow.
# Ensure OpenEMS python bindings are active
export PYTHONPATH=$PYTHONPATH:/foss/tools/openems/python
git clone https://github.com/IHP-GmbH/IHP-Open-PDK.git ihp-pdk-extras
# (Volker's scripts are typically inside libs.tech/openems of the PDK repo)

# 4. CACE (Circuit Automatic Characterization Engine)
git clone https://github.com/efabless/cace.git

# 5. SiEPIC Tools (KLayout integration)
# Usually installed inside KLayout, but we can fetch the macro
git clone https://github.com/SiEPIC/SiEPIC-Tools.git

# 6. UBC PDK (The SiEPIC EBeam GDSFactory wrapper)
# This is a python package, usually installed via pip,
# but cloning allows you to see the source cells.
git clone https://github.com/gdsfactory/ubc.git

echo "Done. When inside Docker, find these in /foss/tools/extra"
