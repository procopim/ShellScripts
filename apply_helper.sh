#!/bin/bash
# A script that takes user flags and applies git apply command on a batch of individual patch files
#1. run stat on all
#2. run check on all
#3. apply to all
#4. revert on all 

#we use /bash in shebang line so that < <(command) in mapfile call does not produce syntax
#apply_helper.sh stat

#$1 is the git apply arg
#$2 is directory; default is current dir if not specified
#$3 is p arguments for git apply

#does not handle symbolic links

#assumes patch is created with equal directory levels for the current and comparator file
# i.e. no use of --directory flag

#CHANGE *.sh to .patch after you're done

#####script starts here#####
echo -------------------------
echo Git Apply helper begin...;
echo please provide args in order:;
echo {[--stat|--check|--apply] [./ | /directory] [-p args]}
echo -------------------------
echo
#read arg

patch_loop()
{   
    #cd to dir we have our patch files in
    $(cd $dir)
    #map results of find to an indexed array
    mapfile -t patch_arr < <(dir | find *.patch)
    declare -a patch_arr
    patch_arr_len=${#patch_arr[@]}

    for i in patch_arr_len
    do
        echo;
        $(git apply $args $p ${arr[i]});
    done
    $(cd $cur_dir)
}

cur_dir=$(pwd)

if ["$2" = ""]
then
    echo "directory is: $(pwd)";
    dir=$(pwd);
else
    echo "directory is: $2";
    dir="$2"
fi

if ["$3" = ""]
then 
    echo no -p flags set
else    
    echo "-p flag is: $3"
    p=$3

case $1 in 
    "stat")
        echo "cmd: git apply --stat"; echo;;
        args="--stat"
        patch_loop
    "check")
        echo "cmd: git apply --check";echo;;
        args="--check"
        patch_loop
    "apply")
        echo "cmd: git apply --verbose";echo;;
        #we need to be able to take the -p args
        #loop over the files
    "revert")
        echo "cmd: git apply -R --verbose"; echo;;
        #we need to be able to take the -p args
        #loop over the files
    *)
        echo sorry please specify one of : stat, check, apply, revert;echo;;
esac

echo ---------END-------------


