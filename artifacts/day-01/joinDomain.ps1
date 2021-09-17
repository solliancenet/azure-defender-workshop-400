Set-DnsClientServerAddress -InterfaceIndex 8 -ServerAddresses ("10.2.0.4")

#add the hosts entry
$line = "10.2.0.4`tad#SUFFIX#.com"
add-content "c:\windows\system32\drivers\etc\HOSTS" $line;

$username = "wsuser"
$password = #PASSWORD# | convertto-securestring -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

add-computer -computername paw-1 -domainname ad#SUFFIX#.com –credential $cred -restart –force