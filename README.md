# SignalSync-Verilog-Traffic-Controller
SignalSync is a Verilog-based traffic light controller using an FSM and clock-driven counter, designed and simulated in AMD Vivado to demonstrate sequential logic and state transitions.

# 🚦 Traffic Light Controller Using Verilog HDL

A digital traffic light controller designed using **Verilog HDL** and **AMD Xilinx Vivado**. This project implements a finite-state machine (FSM) that controls red, yellow, and green traffic light outputs in a predefined sequence.

The design demonstrates fundamental digital design concepts, including sequential logic, state transitions, clock-driven counters, asynchronous reset, and behavioral simulation.

> **Project status:** RTL design and testbench prepared for simulation in Vivado. No physical FPGA board is required.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Objectives](#-objectives)
- [How It Works](#-how-it-works)
- [State Diagram](#-state-diagram)
- [State Encoding](#-state-encoding)
- [Hardware and Software Requirements](#-hardware-and-software-requirements)
- [Project Structure](#-project-structure)
- [Verilog Implementation](#-verilog-implementation)
- [Testbench](#-testbench)
- [Simulation Instructions](#-simulation-instructions)
- [Expected Behavior](#-expected-behavior)
- [Key Concepts Learned](#-key-concepts-learned)
- [Limitations](#-limitations)
- [Future Improvements](#-future-improvements)
- [Applications](#-applications)
- [Author](#-author)

## 📖 Project Overview

Traffic lights are used to regulate vehicle movement and improve road safety. This project models a basic traffic light controller as a synchronous digital system using Verilog HDL.

The controller cycles through three states:

- 🔴 **Red:** Vehicles must stop.
- 🟡 **Yellow:** Drivers should prepare to stop when safe.
- 🟢 **Green:** Vehicles may proceed when the way is clear.

A clock-driven counter determines when the controller transitions from one state to the next. The current state determines which output signal is activated.

The complete design can be simulated on a computer using Vivado's behavioral simulator, allowing the internal state transitions and output waveforms to be examined without physical hardware.

## 🎯 Objectives

- Design a traffic light controller using Verilog HDL.
- Implement a finite-state machine with three states.
- Understand sequential and combinational logic.
- Use a counter to control state-transition timing.
- Implement an asynchronous active-high reset.
- Create a testbench to verify the design.
- Observe and analyze digital waveforms using Vivado.

## ⚙️ How It Works

The controller consists of three main functional blocks.

### 1. Finite-State Machine (FSM)

The FSM stores the current traffic light state and determines the next state.

### 2. Clock-Driven Counter

A counter increments on each rising edge of the clock. When its state-specific threshold is exceeded, the controller advances to the next traffic light state and clears the counter.

### 3. Output Logic

Combinational logic activates the output associated with the current state. Only one traffic light output is active during normal operation.

The controller follows this repeating sequence:

**RED → YELLOW → GREEN → RED**

An asynchronous reset immediately returns the controller to the red state and clears the counter when reset is asserted.

## 🔄 State Diagram

```text
              Reset
                |
                v
          +-----------+
          |    RED    |
          |  count>4  |
          +-----------+
                |
                v
          +-----------+
          |  YELLOW   |
          |  count>2  |
          +-----------+
                |
                v
          +-----------+
          |   GREEN   |
          |  count>4  |
          +-----------+
                |
                +-----------> RED
```

The counter thresholds shown above correspond to the RTL implementation. Because counting starts at zero, the conditions `count > 4` and `count > 2` result in six and four counter increments, respectively, before a transition.

## 🔢 State Encoding

The controller uses a 2-bit register to represent its three states.

| State | Binary Encoding | Red | Yellow | Green |
|---|---|---:|---:|---:|
| RED | `00` | 1 | 0 | 0 |
| YELLOW | `01` | 0 | 1 | 0 |
| GREEN | `10` | 0 | 0 | 1 |

The encoding `11` is unused. A default state branch returns the controller to red and clears the counter if an invalid state is encountered.

## 🛠️ Hardware and Software Requirements

### Software

- **AMD Vivado Design Suite 2026.1** or a compatible Vivado version.
- Verilog HDL support.
- Vivado XSim behavioral simulator.

### Hardware

- A computer running Windows or another supported Vivado operating system.
- **No physical FPGA board or external electronic components are required** for behavioral simulation.

## 📁 Project Structure

Organize the project files as follows:

```text
Traffic-Light-Controller/
│
├── README.md
│
├── traffic_light.v
│
└── traffic_light_tb.v
```

| File | Description |
|---|---|
| `README.md` | Project documentation and instructions |
| `traffic_light.v` | Main RTL design containing the FSM, counter, and output logic |
| `traffic_light_tb.v` | Testbench for generating the clock, applying reset, and monitoring outputs |

## 💻 Verilog Implementation

The design module is named `traffic_light`.

### Module interface

| Signal | Direction | Width | Description |
|---|---|---|---|
| `clk` | Input | 1 bit | Clock signal |
| `reset` | Input | 1 bit | Asynchronous active-high reset |
| `red` | Output | 1 bit | Red light indicator |
| `yellow` | Output | 1 bit | Yellow light indicator |
| `green` | Output | 1 bit | Green light indicator |

### Core logic

The design uses three state parameters:

```verilog
parameter Red    = 2'b00;
parameter Yellow = 2'b01;
parameter Green  = 2'b10;
```

The sequential block updates the state and counter on the rising edge of the clock. The sensitivity list also includes `posedge reset`, enabling asynchronous reset behavior.

A separate combinational block decodes the current state into the red, yellow, and green outputs.

This separation makes the design easier to understand and maintain.

## 🧪 Testbench

The testbench is named `traffic_light_tb` and instantiates the `traffic_light` module as the device under test (DUT).

The testbench performs the following operations:

1. Initializes the clock.
2. Generates a clock with a 10 ns period using a 5 ns half-period.
3. Asserts reset at the beginning of the simulation.
4. Deasserts reset after 10 ns.
5. Monitors the traffic light outputs.
6. Ends the simulation after an additional 300 ns.

The testbench uses `$monitor` to display changes in the output signals and `$finish` to terminate the simulation.

**Note:** The testbench is a simulation-only file. It is not part of the synthesizable traffic light hardware.

## ▶️ Simulation Instructions

Follow these steps to simulate the project in AMD Vivado.

### Step 1: Create a project

1. Open Vivado.
2. Select **Create Project**.
3. Enter the project name `Traffic_Light`.
4. Choose **RTL Project**.
5. Add `traffic_light.v` as a design source.
6. Add `traffic_light_tb.v` as a simulation source.

### Step 2: Select the project target

Since this project is intended for computer-only simulation, select **Do not specify a part or board at this time**, if the option is available in your Vivado version.

No FPGA device selection is necessary for this workflow.

### Step 3: Run behavioral simulation

1. Open the project.
2. Navigate to **Flow Navigator → Simulation**.
3. Select **Run Simulation → Run Behavioral Simulation**.
4. Wait for the simulator to elaborate and launch the testbench.

### Step 4: Inspect the waveforms

Add or inspect the following signals in the waveform window:

- `clk`
- `reset`
- `red`
- `yellow`
- `green`
- `dut.state`
- `dut.count`

The internal signals may be available through the simulation hierarchy.

Observe the reset behavior, clock edges, counter progression, and state transitions.

### Step 5: Check the output sequence

Verify that the outputs follow the intended sequence:

```text
RED → YELLOW → GREEN → RED → ...
```

Confirm that only the output corresponding to the current state is high during normal operation.

**Important:** A successful simulation should be confirmed by inspecting the waveform or simulator output. This README describes the expected behavior; it does not claim that a simulation has already passed.

## 📊 Expected Behavior

With the counter initialized to zero and the given threshold comparisons:

| Current State | Transition Condition | Next State | Counter Increments |
|---|---|---|---:|
| RED | `count > 4` | YELLOW | 6 |
| YELLOW | `count > 2` | GREEN | 4 |
| GREEN | `count > 4` | RED | 6 |

These values represent counter increments per state interval, not real-world seconds.

For the testbench clock period of 10 ns, the nominal state intervals are 60 ns for red, 40 ns for yellow, and 60 ns for green, assuming the clock and reset are initialized as shown and counting begins after reset is deasserted.

Real traffic signals require much longer intervals and additional safety logic.

## 🧠 Key Concepts Learned

This project provides practical experience with:

- **Verilog HDL:** Describing digital hardware using a hardware description language.
- **Finite-State Machines:** Representing and controlling a system through discrete states.
- **Sequential Logic:** Updating registers on clock edges.
- **Combinational Logic:** Decoding the current state into output signals.
- **Counters:** Measuring clock cycles to determine transition timing.
- **Asynchronous Reset:** Initializing the controller independently of the clock.
- **Testbenches:** Verifying a hardware design through simulation.
- **Waveform Analysis:** Understanding the relationship between clock, reset, state, and outputs.
- **Vivado Workflow:** Creating an RTL project and running behavioral simulation.

## ⚠️ Limitations

This is a basic educational traffic light controller.

- The timing is defined in clock cycles rather than real-world seconds.
- The controller models only one set of traffic lights.
- There are no pedestrian signals, vehicle sensors, or emergency override inputs.
- The design does not coordinate multiple intersections.
- No physical FPGA implementation or hardware validation is included.
- The testbench checks basic behavior and is not a comprehensive verification environment.

## 🚀 Future Improvements

Possible extensions include:

1. **Configurable Timing:** Use parameters to change red, yellow, and green durations.
2. **Longer Intervals:** Add a clock divider or clock-enable counter for practical timing.
3. **Pedestrian Crossing:** Add a pedestrian request input and walk indicator.
4. **Vehicle Detection:** Extend the FSM to respond to simulated vehicle sensors.
5. **Four-Way Intersection:** Coordinate two sets of traffic lights with safe transition rules.
6. **Self-Checking Testbench:** Add assertions or checks to automatically detect incorrect output sequences.
7. **FPGA Implementation:** Assign the output signals to physical LEDs and test the design on a supported FPGA board.

## 🌍 Applications

The concepts demonstrated in this project are useful in:

- Traffic signal controller prototypes.
- Digital control systems.
- FSM-based embedded controllers.
- Sequential circuit design.
- FPGA and digital electronics education.
- Timing and state-transition experiments.

## 👨‍💻 Author

**Kishore Naik**

B.Tech — Electronics and Communication Engineering

GitHub: [KishoreBuilds47](https://github.com/KishoreBuilds47)

---

## 📜 License

This project is intended for educational and learning purposes. You may add an open-source license, such as the MIT License, if you want to allow others to reuse and modify the project under its terms.
