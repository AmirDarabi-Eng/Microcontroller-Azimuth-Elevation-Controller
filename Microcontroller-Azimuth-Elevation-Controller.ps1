﻿# run this line in the console to list COM ports
# [System.IO.Ports.SerialPort]::getportnames()
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

# clear console text
clear

# set up COM port with microcontroller (may need to edit COM port number)
$port= new-Object System.IO.Ports.SerialPort COM4,9600,None,8,one
$port.ReadTimeout= 60000  # One minute allowance in case the tracker needs to move a long distance
$port.Open()
$port.DiscardInBuffer()
Write-Host 'COM port open...'

$CurrentTilt=0
$CurrentAzimuth=0
$RelativeTilt
$RelativeAzimuth

# Define the elevation steps
$elevation_steps = 0, 15, 30, 45, 60, 90

# Define the azimuth steps for different elevation patterns
$azimuth_steps_forward = 0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345, 360
$azimuth_steps_backward = 360, 345, 330, 315, 300, 285, 270, 255, 240, 225, 210, 195, 180, 165, 150, 135, 120, 105, 90, 75, 60, 45, 30, 15, 0

# While loop removed for demonstration purposes; it can be re-enabled as needed
foreach ($elevation in $elevation_steps) {
    if ($elevation -eq 90) {
        Write-Host "Setting Elevation to 90 degrees"
        $port.WriteLine("SETUP-TILT")
        Start-Sleep -s 1
        $RelativeTilt= $elevation-$CurrentTilt
        $port.WriteLine("$RelativeTilt")
        Start-Sleep -s 1
        $CurrentTilt=$elevation
    } else {
        Write-Host "Setting Elevation to $elevation degrees"
        $port.WriteLine("SETUP-TILT")
        Start-Sleep -s 1
        $RelativeTilt= $elevation-$CurrentTilt
        $port.WriteLine("$RelativeTilt")
        Start-Sleep -s 1
        $CurrentTilt=$elevation

        if ($elevation -eq 0 -or $elevation -eq 30 -or $elevation -eq 60) {
            $azimuth_steps = $azimuth_steps_forward
        } elseif ($elevation -eq 15 -or $elevation -eq 45) {
            $azimuth_steps = $azimuth_steps_backward
        }

        foreach ($azimuth in $azimuth_steps) {
            Write-Host "Setting Azimuth to $azimuth degrees at Elevation $elevation"
            $port.WriteLine("SETUP-AZ")
            Start-Sleep -s 1
            $RelativeAzimuth= $azimuth-$CurrentAzimuth
            $port.WriteLine("$RelativeAzimuth")
            Start-Sleep -s 1
            $CurrentAzimuth=$azimuth
        }
    }
}

# After all points are complete, print a message and restart the loop
Write-Host "All points complete. Restarting the loop..."
Start-Sleep -s 2

# end-of-run housekeeping (generally won't actually run because there isn't a stop criterion! Someday/maybe...)
$port.Close()
Write-Host 'COM port closed...'
Write-Host 'Session terminated...'
