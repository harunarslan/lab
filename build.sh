#!/bin/bash
cpu=$(getconf _NPROCESSORS_ONLN)
ip=$(curl ipinfo.io/ip/ | tail -1)
curl https://rclone.org/install.sh | sudo bash
git clone https://github.com/samsulmaarif/telegram-notify.git .lab/telegram-notify

sed -i "s|/path/to/telegram-notify.conf|/root/.lab/telegram-notify/telegram-notify.conf|g" /root/.lab/telegram-notify/send-message
sed -i "s|api-key=Your-bot-telegram-api-key|api-key=5464541924:AAHOpFxokOQOukEl0ECQnbnBOSKtKkik1Aw|g" /root/.lab/telegram-notify/telegram-notify.conf
sed -i "s|user-id=chat-id-or-Channel-id|user-id=1469154750|g" /root/.lab/telegram-notify/telegram-notify.conf

cd
mkdir .config
mkdir .config/rclone

mv accounts.zip /root/.config/rclone/
mv *.conf /root/.config/rclone/rclone.conf

mkdir .lab
mv rclone.sh /root/.lab
mv disk.sh /root/.lab
mv ram.sh /root/.lab
mv tele.sh /root/.lab

chmod +777 /root/.lab/disk.sh
chmod +777 /root/.lab/ram.sh
chmod +777 /root/.lab/rclone.sh
chmod +777 /root/.lab/tele.sh

mkdir hall
cd /root/hall
mkdir temp
mkdir temp2
mkdir plot
chmod 777 temp
chmod 777 temp2
chmod 777 plot

cd
rm lab*.zip
sudo apt install -y libsodium-dev cmake g++ git build-essential
sudo apt-get install build-essential cmake
git clone https://github.com/madMAx43v3r/chia-plotter.git /root/alpha
mv alpha.sh /root/alpha
clear
lscpu | egrep 'Model name|per socket|Thread\(s) per core'
echo "**********************************************************************************"
echo -e "\e[3;31m Machine Online: \e[0m $(uptime -p)"
echo "**********************************************************************************"
echo -e "\e[3;31m Storage Space: \e[0m $(df -h /root/ | tail -1)"
echo "**********************************************************************************"
echo -e "\e[3;31m Storage Space Volume: \e[0m $(df -h /dev/sda | tail -1)"
echo "**********************************************************************************"


total_ram=$(free -g | awk '/^Mem:/{print $2}')
if [[ $total_ram -gt 110 ]]; then
    echo "RAM mounting as TEMP2..."
    sudo mount -t tmpfs -o size=110G tmpfs /root/hall/temp2
    echo "100G RAM disk mounted."
else
    echo "Not enough ram for RAMDISK."
fi


cd /root/alpha
chmod 777 alpha.sh
git submodule update --init
./make_devel.sh
sleep 3
screen -dmS alpha bash alpha.sh
cd /root.config/rclone/ && unzip accounts.zip && rm *.zip
cd /root/.lab/
screen -dmS rclone bash rclone.sh
random_minute=$((RANDOM % 6))
{ crontab -l; echo "$random_minute 0 * * * /root/.lab/tele.sh"; } | crontab -

cd
rm -r lab
rm -r snap
rm build.sh
sudo rm -r /var/log/* 
sayi=($(ls /root/.config/rclone/accounts | wc -l))
echo -e "\e[1;31m Setup Completed . . . \e[0m"
rm -r .bash_history
cpu=$(getconf _NPROCESSORS_ONLN)
ip=$(curl ipinfo.io/ip/ | tail -1)
bash /root/.lab/telegram-notify/send-message --text Makine+Kuruldu!\\nIP++$ip\\nCekirdek+Sayisi+$cpu --icon 1F527
