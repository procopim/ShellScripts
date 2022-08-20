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
#$3 is p arguments for git apply - must set to 0 if not using p flag

#does not handle symbolic links

#assumes patch is created with equal directory levels for the current and comparator file
# i.e. no use of --directory flag

#in case statement, a ';;' terminates a clause


#####script starts here#####
echo -------------------------
echo "Git Apply helper begin...";
echo "correct arguments order:" ;
echo "[stat|check|apply] [./ | /directory] [-p args]"
echo -------------------------

patch_loop()
{   
    #cd to dir we have our patch files in
    cd $dir
    #map results of find to an indexed array
    #mapfile -t patch_arr < <(find *.patch)
    patch_arr=( $(find *.patch))
    $(declare -a patch_arr)

    for i in "${patch_arr[@]}"
    do 
        git apply $args $p $i;
    done
    cd $cur_dir
}

#NEED FUNCTION: 
#  when actually applying, you nav to the current file directory, and from there call git apply
#  need to account for leading directories. 

cur_dir=$(pwd)

if [ $2 = "./" ]
then
    echo "patch directory is: $(pwd)";
    dir=$(pwd);
else
    echo "patch directory is: $2";
    dir="$2"
fi

if [ $3 = 0 ]
then 
    echo "no -p flags set"
else    
    echo "-p flag is: $3"
    p="-p $3"
fi

case $1 in 
    "stat")
        args="--stat --verbose"
        patch_loop;;
    "check")
        args="--check --verbose";
        patch_loop;;
    "apply")
        args="--verbose";
        patch_loop;;
    "revert")
        args="-R --verbose";
        patch_loop;;
    *)
        echo sorry please specify one of : stat, check, apply, revert;
        echo;;
esac

echo ---------END-------------