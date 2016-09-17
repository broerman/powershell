powershell
==========


This bash script executes Powershell  via OpenSSH for Windows from Linux

```
Usage: 
            powershell.sh                         # invokes an ugly  Powershell  
            powershell.sh -c 'Command Arg1 Arg2'  # executes "-Command"  -eg. 'Get-Module -ListAvailable'
                                     Command must be quotet!!!   
            powershell.sh -f  Commandfile         # executes ps1 file   

                          -H winhost              #  overwrites exported  POWERSHELLHOST    
                          -u winusername          #  overwrites exported  POWERSHELLDOMAIN\\POWERSHELLUSER
                                     Backslash must be doubled!!!
                          -v be verbose

```

In your  ~/.bashrc you should place variables like this

```bash
export POWERSHELLHOST=windowswithopenssh
export POWERSHELLUSER=Administrator
export POWERSHELLDOMAIN=EXAMPLE
```

To avoid typing your password twice, copy your SSH publickey to your windows home directory.

