powershell
==========


This bash script executes Powershell  via OpenSSH for Windows from Linux

```
Usage:
            powershell.sh                         # invokes Powershell as shell
            powershell.sh -c 'Command Arg1 Arg2'  # invokes Powershell eg. 'Get-Module -ListAvailable'
                              Commands must be quotet!!!   
            powershell.sh -f  Commandfile         # invokes Powershellscript
```

In your  ~/.bashrc you should place Variables like

```bash
export POWERSHELLHOST=windowswithopenssh
export POWERSHELLUSER=Administrator
export POWERSHELLDOMAIN=EXAMPLE
```

To avoid typing your password twice , copy your SSH publickey to your windows home directory.

