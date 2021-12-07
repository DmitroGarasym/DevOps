drives=("sdb" "sdc" "sdd" "sde")

for i in "${drives[@]}"
do
  echo $(parted /dev/"$i" --script -- mklabel msdos) > /dev/null
  echo $(parted /dev/"$i" --script -- mkpart primary ext4 0 100%) > /dev/null
done

yum install epel-release -y > /dev/null
yum install lvm2 -y > /dev/null

pvcreate /dev/sdb1 /dev/sdc1
pvcreate /dev/sdd1 /dev/sde1

vgcreate vol1 /dev/sdb1 /dev/sdc1
vgcreate vol2 /dev/sdd1 /dev/sde1

lvcreate -n vol1 -l 100%FREE vol1
lvcreate -n vol2 -l 100%FREE vol2

mkfs.ext4 /dev/vol1/vol1
mkfs.ext4 /dev/vol2/vol2

mkdir /mnt/vol1
mkdir /mnt/vol2

mount /dev/vol1/vol1 /mnt/vol1
mount /dev/vol2/vol2 /mnt/vol2

UUID_VOL1=$(blkid -s UUID -o value /dev/vol1/vol1)
UUID_VOL2=$(blkid -s UUID -o value /dev/vol2/vol2)

echo "UUID=${UUID_VOL1} /mnt/vol1  ext4 defaults 0 0" >> /etc/fstab
echo "UUID=${UUID_VOL2} /mnt/vol2  ext4 defaults 0 0" >> /etc/fstab