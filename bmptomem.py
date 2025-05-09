#!/usr/bin/env python3
import argparse
from PIL import Image

def main():
    parser = argparse.ArgumentParser(
        description="Convert 3 BMP images into one MEM file for FPGA ROM"
    )
    parser.add_argument(
        "images", metavar="IMG", nargs=3,
        help="Input BMP files (exactly 3)"
    )
    parser.add_argument(
        "-w", "--width", type=int, default=160,
        help="Target width of each image (default: 160)"
    )
    parser.add_argument(
        "-ht", "--height", type=int, default=120,
        help="Target height of each image (default: 120)"
    )
    parser.add_argument(
        "-o", "--output", default="all_images.mem",
        help="Output MEM filename (default: all_images.mem)"
    )
    args = parser.parse_args()

    W, H = args.width, args.height
    total_lines = 0

    with open(args.output, "w") as fout:
        for idx, bmp in enumerate(args.images):
            im = Image.open(bmp).convert("RGB").resize((W, H))
            for y in range(H):
                for x in range(W):
                    r, g, b = im.getpixel((x, y))
                    # 8-bit → 4-bit
                    r4, g4, b4 = r >> 4, g >> 4, b >> 4
                    val = (r4 << 8) | (g4 << 4) | b4
                    fout.write(f"{val:03X}\n")
                    total_lines += 1

    print(f"Wrote {total_lines} lines to '{args.output}' "
          f"({len(args.images)} images of {W}×{H})")

if __name__ == "__main__":
    main()
