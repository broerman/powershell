#!/bin/bash
#  Executes Powershell  via OpenSSH for Windows from Linux
#  16.9.2016 Bernd Broermann


# export  variables POWERSHELLHOST, POWERSHELLUSER and  POWERSHELLDOMAIN  in  your .bashrc 
# otherwise they will be set to
POWERSHELLDOMAIN=${POWERSHELLDOMAIN=EXAMPLE}
POWERSHELLHOST=${POWERSHELLHOST-win2012withopenssh.example.com}
POWERSHELLUSER=${POWERSHELLUSER-$POWERSHELLDOMAIN\\$USER}

DEBUG=${DEBUG-false}
VERBOSE=false

usage () {
        echo "Usage:
            `basename $0`                         # invokes Powershell as shell
            `basename $0` -c 'Command Arg1 Arg2'  # invokes Powershell eg. Get-Module -ListAvailable
                              Commands must be quotet!!!   
            `basename $0` -f  Commandfile         # invokes Powershellscript"   
          
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
 


# if test "X$1" == "X-h" ; then usage ; fi
# if test "X$1" == "X-?" ; then usage ; fi



if test -z $COMMANDFILE 
    then 
       COMMANDFILE="powershell.ps1"         
       if test ! -z "$COMMAND"
             then  echo -e "$COMMAND\n" > $COMMANDFILE 
             else  echo "-" > $COMMANDFILE
       fi
         
    fi

if $VERBOSE ; then 
echo  "
POWERSHELLUSER=  [$POWERSHELLUSER]
POWERSHELLHOST=  [$POWERSHELLHOST]
COMMAND=         [$COMMAND]
COMMANDFILE=     [$COMMANDFILE]
"
cat $COMMANDFILE

set -x

fi

# copy COMMANDFILE to  windows
echo "put $COMMANDFILE" | sftp -q  -b - $POWERSHELLUSER@$POWERSHELLHOST 2>&1 

# execute COMMANDFILE on  windows
ssh -a -x $POWERSHELLUSER@$POWERSHELLHOST Powershell -File $COMMANDFILE

