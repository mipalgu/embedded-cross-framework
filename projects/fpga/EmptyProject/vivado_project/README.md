# Vivado Project Directory

Please place your vivado project in this directory with the HDL files you wish to compile. This folder should represent the root of your project with the project file (EmptyProject.xpr in this example) within it.
A typical vivado folder structure is shown below.

```shell
.
├── EmptyProject.cache
│   ├── compile_simlib
│   │   ├── activehdl
│   │   ├── modelsim
│   │   ├── questa
│   │   ├── riviera
│   │   ├── vcs
│   │   └── xcelium
│   ├── ip
│   │   └── 2022.2
│   └── wt
│       ├── project.wpc
│       ├── synthesis_details.wdf
│       ├── synthesis.wdf
│       └── webtalk_pa.xml
├── EmptyProject.hw
│   └── EmptyProject.lpr
├── EmptyProject.ip_user_files
├── EmptyProject.runs
│   └── synth_1
├── EmptyProject.sim
├── EmptyProject.srcs
│   ├── constrs_1
│   │   └── new
│   │       └── pins.xdc
│   ├── sources_1
│   │   └── new
│   │       └── empty.vhd
│   └── utils_1
│       └── imports
│           └── synth_1
│               └── empty.dcp
├── EmptyProject.xpr
```

