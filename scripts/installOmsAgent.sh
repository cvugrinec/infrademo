# go to [your oms workspaceid ].portal.mms.microsoft.com
# find your workspaceid (-w) and shared key (-s) ...int eh settings tab/ connected sources 
wget https://github.com/Microsoft/OMS-Agent-for-Linux/archive/OMSAgent-201611-v1.2.1-148.tar.gz
tar -zxvf OMSAgent-201611-v1.2.1-148.tar.gz
sudo sh ./omsagent-1.2.0-148.universal.x64.sh --install -w [ YOUR OMS WORKSPACE ID ]  [ YOUr SHARED KEY ]
