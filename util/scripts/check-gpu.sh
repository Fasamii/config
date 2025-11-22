#!/bin/bash
echo "=== GPU(s) Detected ==="
lspci -nnk | grep -A3 -E 'VGA|3D|Display'

echo -e "\n=== Kernel Driver Info ==="
dmesg | grep -i -E 'nvidia|amdgpu|i915|nouveau'

echo -e "\n=== OpenGL Info ==="
glxinfo | grep -E 'OpenGL renderer|OpenGL version'

echo -e "\n=== Vulkan Info ==="
vulkaninfo | grep deviceName

echo -e "\n=== GPU Usage ==="
if command -v nvidia-smi &> /dev/null; then
    nvidia-smi
elif command -v radeontop &> /dev/null; then
    sudo radeontop -d /tmp/radeontop.log -l 1 && cat /tmp/radeontop.log
elif command -v intel_gpu_top &> /dev/null; then
    timeout 1 intel_gpu_top
fi

echo -e "\n=== DRM Devices ==="
ls /dev/dri

echo -e "\n=== Power State ==="
cat /sys/class/drm/card0/device/power/runtime_status

echo -e "\n=== Kernel Errors ==="
journalctl -k | grep -iE 'gpu|drm|error'
