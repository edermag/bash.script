#!/bin/bash

#Conversor de encode, utiliza a app iconv

ICONVBIN='/usr/bin/iconv'  
  
if [ $# -lt 3 ]  
then  
    echo "$0 from_charset to_charset extesion"  
    exit  
fi  
  
for f in `find ./ -name "*.$3" -exec file --mime {} \; | grep $1 | cut -f 1 -d :`  
do  
    if test -f $f  
    then  
        echo -e "\nConvertendo $f"  
        /bin/mv $f $f.old  
        RETMV=$?  
        if [ $RETMV -gt 0 ]; then  
          echo -e "\n Atencao erro no mv"  
          exit 1  
        fi  
  
        $ICONVBIN -f $1 -t $2 $f.old > $f  
        RETICONV=$?  
        if [ $RETICONV -gt 0 ]; then  
          echo -e "\n Atencao erro no iconv"  
          exit 2  
        fi  
  
        /bin/rm $f.old  
        RETRM=$?  
        if [ $RETRM -gt 0 ]; then  
          echo -e "\n Atencao erro no rm"  
          exit 3  
        fi  
    else  
        echo -e "\nArquivo $f nao convertido";  
    fi  
done
