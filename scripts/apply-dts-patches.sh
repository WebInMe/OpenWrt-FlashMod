#!/bin/bash
# apply-dts-patches.sh - Apply DTS patches for extended UBI partitions

set -e

OPENWRT_DIR="${1:-./openwrt}"
DEVICE="${2:-redmi-ax6000}"
FLASH_SIZE="${3:-256mb}"

echo "Applying DTS patches for $DEVICE with $FLASH_SIZE UBI..."

cd "$OPENWRT_DIR"

case "$DEVICE-$FLASH_SIZE" in
  "redmi-ax6000-256mb")
    cat > target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000-ubi-256.dts << 'EOF'
// SPDX-License-Identifier: (GPL-2.0 OR MIT)

/dts-v1/;
#include "mt7986a-xiaomi-redmi-router-ax6000.dtsi"

/ {
  model = "Xiaomi Redmi Router AX6000 (256MB UBI)";
  compatible = "xiaomi,redmi-router-ax6000-ubi-256", "mediatek,mt7986a";
};

&spi_nand_flash {
  mediatek,nmbm;
  mediatek,bmt-max-ratio = <1>;
  mediatek,bmt-max-reserved-blocks = <64>;
};

&partitions {
  partition@580000 {
    label = "crash";
    reg = <0x580000 0x40000>;
    read-only;
  };

  partition@5c0000 {
    label = "crash_log";
    reg = <0x5c0000 0x40000>;
    read-only;
  };

  partition@600000 {
    label = "ubi_kernel";
    reg = <0x600000 0x1e00000>;
  };

  partition@2400000 {
    label = "ubi";
    reg = <0x2400000 0x10000000>;  /* 256MB */
  };
};
EOF
    echo "✓ Applied 256MB UBI patch for Redmi AX6000"
    ;;
    
  "redmi-ax6000-512mb")
    cat > target/linux/mediatek/dts/mt7986a-xiaomi-redmi-router-ax6000-ubi-512.dts << 'EOF'
// SPDX-License-Identifier: (GPL-2.0 OR MIT)

/dts-v1/;
#include "mt7986a-xiaomi-redmi-router-ax6000.dtsi"

/ {
  model = "Xiaomi Redmi Router AX6000 (512MB UBI)";
  compatible = "xiaomi,redmi-router-ax6000-ubi-512", "mediatek,mt7986a";
};

&spi_nand_flash {
  mediatek,nmbm;
  mediatek,bmt-max-ratio = <1>;
  mediatek,bmt-max-reserved-blocks = <64>;
};

&partitions {
  partition@580000 {
    label = "crash";
    reg = <0x580000 0x40000>;
    read-only;
  };

  partition@5c0000 {
    label = "crash_log";
    reg = <0x5c0000 0x40000>;
    read-only;
  };

  partition@600000 {
    label = "ubi_kernel";
    reg = <0x600000 0x1e00000>;
  };

  partition@2400000 {
    label = "ubi";
    reg = <0x2400000 0x20000000>;  /* 512MB */
  };
};
EOF
    echo "✓ Applied 512MB UBI patch for Redmi AX6000"
    ;;
    
  "xiaomi-ax3000t-256mb")
    cat > target/linux/mediatek/dts/mt7986b-xiaomi-mi-router-ax3000t-ubi-256.dts << 'EOF'
// SPDX-License-Identifier: (GPL-2.0 OR MIT)

/dts-v1/;
#include "mt7986b-xiaomi-mi-router-ax3000t.dtsi"

/ {
  model = "Xiaomi Mi Router AX3000T (256MB UBI)";
  compatible = "xiaomi,mi-router-ax3000t-ubi-256", "mediatek,mt7986b";
};

&spi_nand_flash {
  mediatek,nmbm;
  mediatek,bmt-max-ratio = <1>;
  mediatek,bmt-max-reserved-blocks = <64>;
};

&partitions {
  partition@600000 {
    label = "ubi_kernel";
    reg = <0x600000 0x1e00000>;
  };

  partition@2400000 {
    label = "ubi";
    reg = <0x2400000 0x10000000>;  /* 256MB */
  };
};
EOF
    echo "✓ Applied 256MB UBI patch for Xiaomi AX3000T"
    ;;
    
  "xiaomi-ax3000t-512mb")
    cat > target/linux/mediatek/dts/mt7986b-xiaomi-mi-router-ax3000t-ubi-512.dts << 'EOF'
// SPDX-License-Identifier: (GPL-2.0 OR MIT)

/dts-v1/;
#include "mt7986b-xiaomi-mi-router-ax3000t.dtsi"

/ {
  model = "Xiaomi Mi Router AX3000T (512MB UBI)";
  compatible = "xiaomi,mi-router-ax3000t-ubi-512", "mediatek,mt7986b";
};

&spi_nand_flash {
  mediatek,nmbm;
  mediatek,bmt-max-ratio = <1>;
  mediatek,bmt-max-reserved-blocks = <64>;
};

&partitions {
  partition@600000 {
    label = "ubi_kernel";
    reg = <0x600000 0x1e00000>;
  };

  partition@2400000 {
    label = "ubi";
    reg = <0x2400000 0x20000000>;  /* 512MB */
  };
};
EOF
    echo "✓ Applied 512MB UBI patch for Xiaomi AX3000T"
    ;;
    
  *)
    echo "Error: Unknown device/flash combination: $DEVICE-$FLASH_SIZE"
    echo "Supported: redmi-ax6000, xiaomi-ax3000t"
    echo "Flash sizes: 256mb, 512mb"
    exit 1
    ;;
esac

echo "Patches applied successfully!"
