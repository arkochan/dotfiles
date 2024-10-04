function usbtether --wraps='sudo adb shell svc usb setFunctions rndis' --description 'alias usbtether=sudo adb shell svc usb setFunctions rndis'
    sudo adb shell svc usb setFunctions rndis $argv

end
