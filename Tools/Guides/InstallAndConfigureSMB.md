#Make sure device is up to date.

#Connect to device
#Get the IP Address (ifconfig)

#Run Command:
    sudo apt-get install samba samba-common-bin

#Configure samba
    sudo nano /etc/samba/smb.conf
    
    #Confirm Settings:
    workgroup = WORKGROUP
    wins support = yes

    #Define Shared Folder:
    [PiShare]
    comment=Raspberry Pi Share
    path=/home/pi/share
    browseable=Yes
    writeable=Yes
    only guest=no
    create mask=0777
    directory mask=0777
    public=no

#Set network user access:
sudo smbpasswd -a pi