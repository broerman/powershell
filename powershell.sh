#!/bin/bash
#  Executes Powershell  via OpenSSH for Windows from Linux
#  16.9.2016 Bernd Broermann
#  19.9.2016 Bernd Broermann


# export  variables POWERSHELLHOST, POWERSHELLUSER and  POWERSHELLDOMAIN  in  your .bashrc 
# otherwise they will be set to
POWERSHELLDOMAIN=${POWERSHELLDOMAIN=EXAMPLE}
POWERSHELLHOST=${POWERSHELLHOST-win2012withopenssh.example.com}
POWERSHELLUSER=${POWERSHELLUSER-$USER}

DEBUG=${DEBUG-false}
VERBOSE=false

usage () {
        echo "Usage: 
            `basename $0`                         # invokes an ugly  Powershell  
            `basename $0` -c 'Command Arg1 Arg2'  # executes \"-Command\"  -eg. 'Get-Module -ListAvailable'
                                     Command must be quotet!!!   
            `basename $0` -f  Commandfile         # executes ps1 file   

                          -H winhost              #  overwrites exported  POWERSHELLHOST    
                          -u winusername          #  overwrites exported  POWERSHELLDOMAIN\\\\\POWERSHELLUSER
                                     Backslash must be doubled!!!
                          -v be verbose"
          
        exit 1
}




while getopts 'c:f:u:H:hv' OPTION ; do
  case $OPTION in
    u)   POWERSHELLUSER=$OPTARG;;
    H)   POWERSHELLHOST=$OPTARG;;
    c)   COMMAND=$OPTARG;;
    f)   COMMANDFILE=$OPTARG ;;
    v)   VERBOSE=true ;;
    h)   usage;;


  esac
done
 


if test -z $COMMANDFILE 
    then 
       COMMANDFILE="powershell.ps1"         
       if test ! -z "$COMMAND"
             then  echo -e "$COMMAND\n" > $COMMANDFILE 
             else  COMMANDFILE="-"
       fi
         
    fi

if $VERBOSE ; then 
echo  "
POWERSHELLUSER=  [$POWERSHELLUSER]
POWERSHELLHOST=  [$POWERSHELLHOST]
POWERSHELLDOMAIN=  [$POWERSHELLDOMAIN]
COMMAND=         [$COMMAND]
COMMANDFILE=     [$COMMANDFILE]
"
set -x

fi

# copy COMMANDFILE to  windows
if test $COMMANDFILE != "-" ; then 
echo "put $COMMANDFILE" | sftp -b - $POWERSHELLDOMAIN\\$POWERSHELLUSER@$POWERSHELLHOST  &>/dev/null
# rm $COMMANDFILE
fi

# execute COMMANDFILE on  windows

ssh -a -x $POWERSHELLDOMAIN\\$POWERSHELLUSER@$POWERSHELLHOST Powershell -File $COMMANDFILE

