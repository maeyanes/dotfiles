function killadobe
	sudo -H killall -9 -v CCXProcess \"Core Sync\" \"Adobe Desktop Service\" \"Creative Cloud Helper\" AdobeCRDaemon AdobeIPCBroker; pkill -f CCLibrary
end