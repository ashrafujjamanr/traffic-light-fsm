# 🚦 Traffic Light Controller (FSM)

A simple RTL design of a Traffic Light Controller implemented using a Finite State Machine (FSM). The controller cycles through highway and side-road traffic signals with configurable timing, verified using a SystemVerilog testbench and simulated using Icarus Verilog + GTKWave.

---

## 🎯 Project Description

This project models a **traffic intersection** with two roads:

- **Highway (Main Road)**
- **Side Road**

The signal operates in the following sequence:

1. Highway — **Green**
2. Highway — **Yellow**
3. Highway — **Red** / Side Road — **Green**
4. Side Road — **Yellow**
5. Repeat

The FSM drives the light outputs based on timers for each state.

---

## 🧩 FSM States & Descriptions

| State Name              | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `HG_SR` (Highway Green / Side Red) | Highway traffic flows, side road is stopped                     |
| `HY_SR` (Highway Yellow / Side Red) | Highway preparing to stop                                       |
| `HR_SG` (Highway Red / Side Green) | Side road traffic flows, highway is stopped                     |
| `HR_SY` (Highway Red / Side Yellow) | Side road preparing to stop                                    |

Optional: Add a state diagram later in `/docs/fsm_diagram.png`.

---

## ⏱️ Timing Parameters

(Default values used in RTL — modify as needed)

| Signal Phase     | Duration |
|-----------------|---------:|
| Highway Green   | 10 s     |
| Highway Yellow  | 3 s      |
| Side Green      | 7 s      |
| Side Yellow     | 3 s      |

> Timing is implemented using a counter inside the FSM.

---

## 🛠️ Build & Simulation Steps

### **1️⃣ Compile the RTL + Testbench**

From the `sim/` folder:

```bash
iverilog -g2012 -o traffic_sim \
  ../rtl/traffic_light_controller.v \
  ../tb/tb_traffic_light_controller.v
