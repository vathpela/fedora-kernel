#!/bin/bash
set -e

. /etc/os-release

kernelver=$1 && shift
rootfs=$1 && shift
variant=$1 && shift

output="${rootfs}/lib/modules/$KernelVer/bls.conf"
date=$(date -u +%Y%m%d%H%M%S)

if [ "${variant:-5}" = "debug" ]; then
    debugname=" with debugging"
else
    debugname=""
fi

cat >${output} <<EOF
title ${NAME} (${kernelver}) ${VERSION} ${debugname}
linux ${bootprefix}/vmlinuz-${kernelver}
initrd ${bootprefix}/initramfs-${kernelver}.img
options \$kernelopts
id ${ID}-${date}-${kernelver}
grub_users \$grub_users
grub_arg --unrestricted
grub_class kernel${variant}
EOF
