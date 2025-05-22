# Preparation

In order for raspberrymatic to run correctly some preparation is necassary
Information kan be found [here](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Docker-OCI#container-host-dependencies)


```
sudo apt install wget ca-certificates build-essential bison flex libssl-dev gpg
wget -qO - https://apt.pivccu.de/piVCCU/public.key | sudo gpg --dearmor -o /usr/share/keyrings/pivccu-archive-keyring.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/pivccu-archive-keyring.gpg] https://apt.pivccu.de/piVCCU stable main" >/etc/apt/sources.list.d/pivccu.list'
sudo apt update
sudo apt install pivccu-modules-dkms
```