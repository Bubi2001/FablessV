# ASIC Specification: FAB-V-DIG01 (Digital SoC)

**Project:** Custom RISC-V SoC with DSP Acceleration

**Process Node:** SKY130 (130nm CMOS)

**Design Type:** Fully Digital

## 1. General Operating Conditions & Constraints

| Parameter | Specification | Notes |
| --- | --- | --- |
| **Core Voltage ($V_{DD}$)** | 1.8 V | Nominal core supply. |
| **I/O Voltage ($V_{DDIO}$)** | 3.3 V | 5V tolerant pads preferred if library permits. |
| **Clock Frequency ($f_{clk}$)** | 50 MHz – 100 MHz | Target: 100 MHz typical. |
| **Power Budget** | $<150mW$ | Estimated dynamic power at $f_{clk\_max}$. |
| **System Interconnect** | TileLink / Wishbone | Architecture dependent (Chipyard vs. Caravel). |

## 2. Processor Core Specifications

* **Architecture:** RISC-V 32-bit

* **Core:** PicoRV32.

## 3. Accelerator A: Reconfigurable Filter Unit (RFU)

* **Interface:** Memory Mapped Slave (AHB/Wishbone).
* **Architecture:** 64-Tap Systolic Array / MAC Engine.
* **Computational Resources:** 4x Parallel Multiply-Accumulate (MAC) units.
* **Throughput:** 1 Output Sample / 16 clock cycles.
* **Data Formats:**
* Input: 16-bit Signed Integer (Q1.15).
* Accumulator: 40-bit (Guard bits to prevent overflow).

* **Operating Modes:**
1. **FIR Mode:** Standard convolution.
2. **IIR Mode:** Circular buffer feedback (Biquad implementation).
3. **Adaptive Mode:** Least Mean Squares (LMS) algorithm support.

## 4. Accelerator B: CORDIC Co-Processor

* **Interface:** Memory Mapped Slave (AHB/Wishbone).

* **Architecture:** Shift-n-Add

* **Function:** Trigonometric functions.

## 5. Memory & Peripherals

* **Primary Memory (SRAM):** 16 KB Total Tightly Coupled Memory.
* Configuration: Split 8 KB Instruction / 8 KB Data.

* **Boot Media:** 4 KB Mask ROM (SPI Bootloader).
* **Communication Interfaces:**
* 2x SPI Master (High-speed, target 50 MHz).
* 1x I2C Master.
* 1x UART (Debug console).

* **System Timing:** 64-bit Real-Time Counter (`mtime`/`mtimecmp`).

## 6. Verification & Performance Metrics

| Metric | Target | Verification Method |
| --- | --- | --- |
| **Core Efficiency** | $>1.0\text{ DMIPS/MHz}$ | Dhrystone Benchmark |
| **DSP Efficiency** | $<5\%$ CPU Load | 64-tap FIR processing of 44.1 kHz audio stream. |
| **LVS/DRC** | 0 Violations | Magic / KLayout / Netgen |
