#!/bin/bash

#!/bin/bash
 
touch checkedurls.txt
touch webpage.html
cat AddressList.txt | while read -s url; do
case $url in
 http*)
     touch webpage.html
     echo -n "" > webpage.html
         wget -q -O webpage.html  $url || echo "$url FAILED"
        if ! grep -q "$url"* checkedurls.txt ; then
            echo "$url INIT"
            echo "$url $(md5sum webpage.html | awk '{print $1}')" >> checkedurls.txt
        else
            cat checkedurls.txt | while read -s urlc; do
                website=$(echo "$urlc " | awk '{print $1}')
                if [ "$website" == "$url" ] ; then
                    old=$(echo "$urlc" | awk '{print $2}')
                    refreshed=$(echo "$(md5sum webpage.html | awk '{print $1}')")
                    if [ "$refreshed" != "$old" ] ; then
                        echo "$website"
                    fi
                fi
            done
        fi    
esac
 
done