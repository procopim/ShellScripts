#!/bin/sh
# A script that takes user flags and applies git apply command on a batch of individual patch files
#1. run stat on all
#2. run check on all
#3. apply to all
#4. revert on all 

#apply_helper.sh stat




#####script starts here#####
echo -------------------------
echo Git Apply helper begin...
echo -------------------------
echo
#read arg

case $1 in 
    "stat")
        echo "git apply --stat"; echo;;
        #loop over the files
    "check")
        echo "git apply --check";echo;;
        #loop over the files
    "apply")
        echo "git apply --verbose";echo;;
        #we need to be able to take the -p args
        #loop over the files
    "revert")
        echo "git apply -R --verbose"; echo;;
        #we need to be able to take the -p args
        #loop over the files
    *)
        echo sorry please specify one of : stat, check, apply, revert;echo;;
esac
echo ---------END-------------


