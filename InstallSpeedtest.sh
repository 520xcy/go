PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

read -p "是否需要安装speedtest(y/n):" START
if [[ ${START} != "y" ]]; then
    exit 0
fi

yum install -y wget git
cd ~
wget https://nodejs.org/dist/v10.16.0/node-v10.16.0-linux-x64.tar.xz
tar xvf node-v10.16.0-linux-x64.tar.xz
cp -R ~/node-v10.16.0-linux-x64/bin/* /usr/bin/
cp -R ~/node-v10.16.0-linux-x64/include/* /usr/include/
cp -R ~/node-v10.16.0-linux-x64/lib/* /usr/lib/
cp -R ~/node-v10.16.0-linux-x64/share/* /usr/share/

git clone https://github.com/adolfintel/speedtest.git && cd speedtest && git checkout node
npm i
npm i -g pm2
mv ~/speedtest/src/public/index.html ~/speedtest/src/public/index.html.bak
mv ~/speedtest/src/public/example-gauges.html ~/speedtest/src/public/index.html
pm2 start ~/speedtest/src/SpeedTest.js

echo 'Speedtest已启用,默认端口:8888'

read -p "是否需要安装开机启动(y/n):" STARTUP
if [[ ${STARTUP} == "y" ]]; then
    pm2 save
    pm2 startup
fi
