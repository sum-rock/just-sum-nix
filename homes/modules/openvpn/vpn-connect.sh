#!/bin/bash

# https://support.nordvpn.com/Connectivity/Linux/1047409422/Connect-to-NordVPN-using-Linux-Terminal.htm
sudo openvpn --config "$HOME/.openvpn/us2950.nordvpn.com.udp.ovpn" --auth-user-pass "$HOME/.openvpn/credentials.txt" 
