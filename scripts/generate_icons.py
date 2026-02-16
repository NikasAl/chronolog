#!/usr/bin/env python3
"""
Generate app icons for Flutter project (Android, iOS, Web)
"""

from PIL import Image
import os
import sys

# Source logo
SOURCE_PATH = "/home/z/my-project/upload/pasted_image_1771271400472.png"
PROJECT_PATH = "/home/z/my-project/chronolog"

# Android mipmap sizes
ANDROID_SIZES = {
    "mdpi": 48,
    "hdpi": 72,
    "xhdpi": 96,
    "xxhdpi": 144,
    "xxxhdpi": 192,
}

# iOS AppIcon sizes
IOS_SIZES = [
    (20, "Icon-App-20x20@1x.png"),
    (40, "Icon-App-20x20@2x.png"),
    (60, "Icon-App-20x20@3x.png"),
    (29, "Icon-App-29x29@1x.png"),
    (58, "Icon-App-29x29@2x.png"),
    (87, "Icon-App-29x29@3x.png"),
    (40, "Icon-App-40x40@1x.png"),
    (80, "Icon-App-40x40@2x.png"),
    (120, "Icon-App-40x40@3x.png"),
    (76, "Icon-App-76x76@1x.png"),
    (152, "Icon-App-76x76@2x.png"),
    (167, "Icon-App-83.5x83.5@2x.png"),
    (1024, "Icon-App-1024x1024@1x.png"),
]

# Web icon sizes
WEB_SIZES = [
    (192, "Icon-192.png"),
    (512, "Icon-512.png"),
    (192, "Icon-maskable-192.png"),
    (512, "Icon-maskable-512.png"),
]


def resize_image(img, size):
    """Resize image to exact size with high quality"""
    return img.resize((size, size), Image.Resampling.LANCZOS)


def generate_android_icons(img):
    """Generate Android mipmap icons"""
    print("📱 Generating Android icons...")
    
    for density, size in ANDROID_SIZES.items():
        dir_path = f"{PROJECT_PATH}/android/app/src/main/res/mipmap-{density}"
        os.makedirs(dir_path, exist_ok=True)
        
        icon = resize_image(img, size)
        icon.save(f"{dir_path}/ic_launcher.png", "PNG")
        print(f"  ✓ mipmap-{density}/ic_launcher.png ({size}x{size})")


def generate_ios_icons(img):
    """Generate iOS AppIcon icons"""
    print("🍎 Generating iOS icons...")
    
    dir_path = f"{PROJECT_PATH}/ios/Runner/Assets.xcassets/AppIcon.appiconset"
    os.makedirs(dir_path, exist_ok=True)
    
    for size, filename in IOS_SIZES:
        icon = resize_image(img, size)
        icon.save(f"{dir_path}/{filename}", "PNG")
        print(f"  ✓ {filename} ({size}x{size})")
    
    # Generate Contents.json
    contents = '''{
  "images" : [
    {
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "20x20",
      "filename" : "Icon-App-20x20@2x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "20x20",
      "filename" : "Icon-App-20x20@3x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "29x29",
      "filename" : "Icon-App-29x29@2x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "29x29",
      "filename" : "Icon-App-29x29@3x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "40x40",
      "filename" : "Icon-App-40x40@2x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "40x40",
      "filename" : "Icon-App-40x40@3x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "2x",
      "size" : "60x60",
      "filename" : "Icon-App-76x76@2x.png"
    },
    {
      "idiom" : "iphone",
      "scale" : "3x",
      "size" : "60x60",
      "filename" : "Icon-App-83.5x83.5@2x.png"
    },
    {
      "idiom" : "ios-marketing",
      "scale" : "1x",
      "size" : "1024x1024",
      "filename" : "Icon-App-1024x1024@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "20x20",
      "filename" : "Icon-App-20x20@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "20x20",
      "filename" : "Icon-App-40x40@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "29x29",
      "filename" : "Icon-App-29x29@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "29x29",
      "filename" : "Icon-App-58x58@2x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "40x40",
      "filename" : "Icon-App-40x40@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "40x40",
      "filename" : "Icon-App-80x80@2x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "1x",
      "size" : "76x76",
      "filename" : "Icon-App-76x76@1x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "76x76",
      "filename" : "Icon-App-152x152@2x.png"
    },
    {
      "idiom" : "ipad",
      "scale" : "2x",
      "size" : "83.5x83.5",
      "filename" : "Icon-App-167x167@2x.png"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}'''
    with open(f"{dir_path}/Contents.json", "w") as f:
        f.write(contents)
    print("  ✓ Contents.json")


def generate_web_icons(img):
    """Generate Web icons"""
    print("🌐 Generating Web icons...")
    
    dir_path = f"{PROJECT_PATH}/web/icons"
    os.makedirs(dir_path, exist_ok=True)
    
    for size, filename in WEB_SIZES:
        icon = resize_image(img, size)
        icon.save(f"{dir_path}/{filename}", "PNG")
        print(f"  ✓ {filename} ({size}x{size})")
    
    # Favicon for web root
    favicon = resize_image(img, 32)
    favicon.save(f"{PROJECT_PATH}/web/favicon.png", "PNG")
    print("  ✓ favicon.png (32x32)")


def main():
    print("⏳ ChronoLog Icon Generator")
    print("=" * 40)
    
    # Load source image
    if not os.path.exists(SOURCE_PATH):
        print(f"❌ Source image not found: {SOURCE_PATH}")
        sys.exit(1)
    
    img = Image.open(SOURCE_PATH)
    print(f"📐 Source: {img.size[0]}x{img.size[1]}")
    
    # Convert to RGBA if needed
    if img.mode != 'RGBA':
        img = img.convert('RGBA')
    
    # Generate all icons
    generate_android_icons(img)
    generate_ios_icons(img)
    generate_web_icons(img)
    
    print("=" * 40)
    print("✅ All icons generated successfully!")


if __name__ == "__main__":
    main()
