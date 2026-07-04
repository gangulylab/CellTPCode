# System requirement
Any Platform with MATLAB works. More than 32GB RAM is recommended. The codes were tested on MATLAB R2020b.
(No additional hardware or third-party software is required)

# Installation
1. MATLAB should be installed prior to the code run. 
2. Download or clone this repository.
3. Add the 'func' folder to the path and save the path.

# Setting the data location
The scripts do not hard-code any machine-specific paths. Each script that loads
data defines a `data_root` variable near the top, for example:

```matlab
data_root = 'Transplant_Data';   % <-- set this to your data folder
```

Set `data_root` to the folder where you downloaded the dataset, then the script
builds the remaining paths with `fullfile`, so it runs on Windows, macOS, and
Linux without further edits.

# Getting started
Modulated cell detection and Microcirculatory dynamic analysis has Demo with sample data. Please check the instruction guide in the folder.
