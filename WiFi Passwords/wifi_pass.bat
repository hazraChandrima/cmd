:: this batch script extracts WiFi passowrds of all the interfaces, your device has previously connected to, and saves them in a file named wifi_passwords.txt 
:: run this script in your terminal simply by writing the name of the batch file in the saved directory 


@echo off
setlocal enabledelayedexpansion

del wifi_passwords.txt 
(
	echo WiFi PASSWORDS OF ALL PROFILES THIS DEVICE HAS BEEN CONNECTED TO 
	echo(
	echo Profile Name     	  :   Wi-Fi Password 	
	echo ----------------   	 ------------------- 
) >> wifi_passwords.txt 

echo WiFi PASSWORDS OF ALL PROFILES THIS DEVICE HAS BEEN CONNECTED TO 
echo(
echo Profile Name      	 :   Wi-Fi Password 
echo ----------------    	------------------- 

for /F "tokens=2 delims=:" %%a in ('netsh wlan show profile ^| findstr /C:"All User Profile"') do (
    set "wifi_name=%%a"
    set "wifi_name=!wifi_name:~1!"
    set "wifi_pwd="

    for /F "tokens=2 delims=:" %%F in ('netsh wlan show profile "!wifi_name!" key^=clear ^| findstr /C:"Key Content"') do (
        set "wifi_pwd=%%F"
    )
    
    if defined wifi_pwd (
        echo !wifi_name! 		:	 !wifi_pwd!
	echo !wifi_name! 		:	 !wifi_pwd! >> wifi_passwords.txt
    ) else (
        echo !wifi_name! 		:	 [No password found]
	echo !wifi_name! 		:	 [No password found] >> wifi_passwords.txt
    )
)

echo( 
echo All Profile names with their WiFi passwords have been saved in file ".\wifi_passwords.txt" successfully.
