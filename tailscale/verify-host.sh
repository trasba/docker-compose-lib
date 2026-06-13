#!/usr/bin/env bash

# Ensure the script runs within an isolated subshell environment
(
echo "=== Running Host Pre-requisite Diagnostics ==="
echo ""

# 1. Gather status metrics cleanly
DOCKER_V6=$(docker info --format '{{json .IPv6}}' 2>/dev/null)
IPV4_FWD=$(sysctl -n net.ipv4.ip_forward 2>/dev/null)
IPV6_FWD=$(sysctl -n net.ipv6.conf.all.forwarding 2>/dev/null)

STATUS_OK=true

# 2. Evaluate Docker Daemon configuration
if [ "$DOCKER_V6" = "true" ]; then
    echo "✅ Docker Engine: IPv6 routing pool is ACTIVE."
else
    echo "❌ Docker Engine: IPv6 pool is DISABLED or daemon is stopped."
    echo "    -> Action: Ensure /etc/docker/daemon.json contains valid address pools and run:"
    echo "       sudo systemctl restart docker"
    STATUS_OK=false
fi

echo ""

# 3. Evaluate Kernel Packet Forwarding status
if [ "$IPV4_FWD" = "1" ] && [ "$IPV6_FWD" = "1" ]; then
    echo "✅ Kernel Forwarding: Dual-stack packet forwarding is FULLY OPERATIONAL."
else
    echo "❌ Kernel Forwarding: Configuration is MISSING or INCOMPLETE."
    echo "    Current Status -> IPv4 Forwarding: ${IPV4_FWD:-0} | IPv6 Forwarding: ${IPV6_FWD:-0}"
    echo "    -> Action: Execute these commands to permanently resolve the path:"
    echo "       sudo mkdir -p /etc/sysctl.d"
    echo "       echo 'net.ipv4.ip_forward = 1' | sudo tee /etc/sysctl.d/99-tailscale.conf"
    echo "       echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf"
    echo "       sudo sysctl -p /etc/sysctl.d/99-tailscale.conf"
    STATUS_OK=false
fi

echo ""
echo "--------------------------------------------------"
if [ "$STATUS_OK" = "true" ]; then
    echo "🚀 SUCCESS: Host environment perfectly matches universal library requirements."
else
    echo "⚠️  ATTENTION: Please apply the missing actions indicated above to prevent routing leaks."
fi
)