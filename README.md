# Microcontroller Azimuth and Elevation Controller

This repository contains a PowerShell script designed to control a microcontroller's azimuth and elevation settings for a solar tracker. The script adjusts azimuth rotation based on specified elevation levels, implementing specific forward and backward rotation patterns.

## Features

- **Elevation Control:** Adjusts the elevation of the solar tracker in predefined steps.
- **Azimuth Control:** Rotates the azimuth forward or backward based on the current elevation.
- **Configurable Steps:** Elevation and azimuth steps can be customized in the script.

## Elevation and Azimuth Patterns

- **0°, 30°, 60° Elevation:** Azimuth rotates from 0° to 360° in 15° steps.
- **15°, 45° Elevation:** Azimuth rotates from 360° to 0° in 15° steps.
- **90° Elevation:** No azimuth rotation, only elevation adjustment.

## Usage

1. Set up the COM port connection to your microcontroller.
2. Run the PowerShell script to start controlling the azimuth and elevation.
3. The script will loop through the defined steps and print the current settings to the console.

## Requirements

- PowerShell
- Microcontroller connected to a COM port
- Properly configured serial port settings

## Getting Started

To use this script, follow these steps:

1. Clone the repository to your local machine.
   ```sh
   git clone https://github.com/AmirDarabi-UK/Microcontroller-Azimuth-Elevation-Controller.git
