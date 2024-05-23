#For One Partition Created

sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%  ##Activating the Drive
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1
sudo mkdir /datadrive                                                 ##
sudo mount /dev/sdc1 /datadrive
