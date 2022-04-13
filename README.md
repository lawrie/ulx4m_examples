# Verilog examples for the Ulx4m ECP5 FPGA board

## Introduction

Some of these examples are from the [Odysseus project](https://github.com/ulx3s/fpga-odysseus).

The uart projects (protocols/echo and protocols/serialtx) need an FTDI chip, so only work if the Ulx4m Hat is used.

If you have USB connected to the FTDI chip then you can run the examples using `make prog`, otherwise you need the dfu bootloader loaded in flash memory and USB from the PC connected to the FPGA, i.e you should use the usb micro or USB C connector on the I/O board.

To run examples using the dfu bootloader, hole down btn 1 when powering up the board and do `make dfu`.

The pong game in hdmi/game needs buttons connected to gpio[5], gpio[6] and gpi[7]. Player 1 uses btn[1] and btn[2] on the module.
