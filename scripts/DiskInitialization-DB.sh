sudo parted /dev/sde --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sde1
sudo partprobe /dev/sde1
sudo mkdir /datadrive_newtest
sudo mount /dev/sde1 /datadrive
