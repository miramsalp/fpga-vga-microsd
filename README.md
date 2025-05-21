# VGA Image Switcher on Basys3

This project demonstrates a simple **image switcher on a VGA display** using the **Basys3 FPGA board**. It shows **3 different images** stored in memory and allows switching between them using **switches SW0 and SW1**.

## Project Overview

- Displays 3 images on a VGA monitor connected to Basys3.
- Uses **VGA protocol** to output 160x120 image (or other resolution if modified).
- Images are stored in BRAM as `.mem` format.
- Input switches **SW0** and **SW1** are used to select which image to display.

## Tech Stack

- **Verilog** (for VGA controller and image selection logic)
- **Python** (for converting BMP files into `.mem` format)
- **Vivado** (for synthesis and bitstream generation)
- **Basys3 FPGA board**

## Preparing Image Memory

Use the provided `bmptomem.py` script to convert 3 BMP images into a single memory file.

### Supported Image Format

- Must be **.bmp**
- Recommended size: **160x120 pixels**
- Color format: RGB444 (1 byte per pixel)

### Conversion on Python

```bash
python bmptomem.py image1.bmp image2.bmp image3.bmp -o all_image.mem
---
### Demo

This is showing how images change when toggling switches SW0 and SW1:

![VGA Demo](./asset/demo.gif)
