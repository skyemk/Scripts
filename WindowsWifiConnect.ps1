# Define variables
$wifiName = "Name"
$wifiPassword = "Password"
$profileXmlPath = "$env:TEMP\$wifiName.xml"

# Create the Wi-Fi profile XML content
$profileXml = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
    <name>$wifiName</name>
    <SSIDConfig>
        <SSID>
            <name>$wifiName</name>
        </SSID>
    </SSIDConfig>
    <connectionType>ESS</connectionType>
    <connectionMode>auto</connectionMode>
    <MSM>
        <security>
            <authEncryption>
                <authentication>WPA2PSK</authentication>
                <encryption>AES</encryption>
                <useOneX>false</useOneX>
            </authEncryption>
            <sharedKey>
                <keyType>passPhrase</keyType>
                <protected>false</protected>
                <keyMaterial>$wifiPassword</keyMaterial>
            </sharedKey>
        </security>
    </MSM>
</WLANProfile>
"@

# Save the profile to a file
$profileXml | Out-File -Encoding UTF8 -FilePath $profileXmlPath

# Add the Wi-Fi profile
netsh wlan add profile filename="$profileXmlPath" user=current

# Connect to the Wi-Fi network
netsh wlan connect name="$wifiName"

# Clean up (optional)
Remove-Item $profileXmlPath
