#!/bin/bash

. ./scripts/funcations.sh

# 开始克隆仓库，并行执行
clone_repo $openwrt_repo openwrt-23.05 openwrt &
clone_repo $immortalwrt_repo master immortalwrt &
clone_repo $immortalwrt_repo openwrt-21.02 immortalwrt_21 &
clone_repo $immortalwrt_repo openwrt-23.05 immortalwrt_23 &
clone_repo $immortalwrt_pkg_repo master immortalwrt_pkg &
clone_repo $immortalwrt_pkg_repo openwrt-21.02 immortalwrt_pkg_21 &
clone_repo $immortalwrt_luci_repo master immortalwrt_luci &
clone_repo $immortalwrt_luci_repo openwrt-21.02 immortalwrt_luci_21 &
clone_repo $immortalwrt_luci_repo openwrt-23.05 immortalwrt_luci_23 &
clone_repo $lede_repo master lede &
clone_repo $lede_luci_repo master lede_luci &
clone_repo $lede_pkg_repo master lede_pkg &
clone_repo $openwrt_repo main openwrt_ma &
clone_repo $openwrt_repo openwrt-22.03 openwrt_22 &
clone_repo $openwrt_pkg_repo master openwrt_pkg_ma &
clone_repo $lienol_repo 23.05 Lienol &
clone_repo $lienol_pkg_repo main Lienol_pkg &
clone_repo $openwrt_add_repo master OpenWrt-Add &
clone_repo $passwall_pkg_repo main passwall_pkg &
clone_repo $passwall_luci_repo main passwall_luci &
clone_repo $dockerman_repo master dockerman &
clone_repo $diskman_repo master diskman &
clone_repo $docker_lib_repo master docker_lib &
clone_repo $mosdns_repo v5 mosdns &
clone_repo $mosdns_pkg master mosdns_pkg &
clone_repo $sirpdboy_repo main sirpdboy &
clone_repo $speedtest_repo master netspeedtest &

wait

# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' openwrt/package/base-files/files/etc/shadow
# Modify default IP (FROM 192.168.1.1 CHANGE TO 192.168.1.99 )
sed -i 's/192.168.1.1/192.168.1.99/g' openwrt/package/base-files/files/bin/config_generate
echo '修改机器名称' 替换
sed -i 's/OpenWrt/Phicomm-N1/g' package/base-files/files/bin/config_generate
echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
# firewall custom 写入
echo "iptables -t nat -I POSTROUTING -o pppoe-WAN -j MASQUERADE" >> package/network/config/firewall/files/firewall.user
exit 0
