# 3D-printable case for Orange Pi Zero

## License
Creative Commons License:
`Orange Pi Zero Case` by Phil Dubach is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

Based on a work at https://github.com/phildubach/OrangePiZeroCase.

See also: https://www.thingiverse.com/thing:2798732

## Printing
* Print bottom shell with supports, but only allow supports from build plate.
  Bridges should not need any support, but the holes for the screw heads do.
* Diameters for small holes can be tricky. If the M3 screws don't fit, change
  `hole_d` in `OrangePiZero_lid.scad`.

## Assembly
* The Orange Pi fits pretty snugly into the bottom shell. Insert the end with
  the USB and Ethernet connectors first. Then flex the shell a tiny bit while
  pushing the PCB into place.
* Unplug the antenna and thread the connector through the center hole of the
  lid, before plugging it in again. This is easier than trying to push most of
  the antenna through from the bottom.
