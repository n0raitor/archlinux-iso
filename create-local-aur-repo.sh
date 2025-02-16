#!/bin/bash

###################################
# Generate Local Repo for ArchISO #
###################################

# Input validation
if [ $# -eq 0 ]
then
    echo "No Arguments supplied, exiting..."
    exit 0

else
    if [ $1 = "--big" ]
    then
        echo "Starting \"Big Aur Repo\" Mode"
        source_file="./aur_packages_big"  # Do not enter # Symbols (no # Skipping included
    elif [ $1 = "--minimal" ]
    then
        echo "Starting \"Minimal Aur Repo\" Mode"
        source_file="./aur_packages"  # Do not enter # Symbols (no # Skipping included
    else
        echo "Invalid Arguments, exiting ..."
        exit 0
    fi
    if [ $2 = "--update" ]
    then
        echo "Updating AUR Packages"
        sudo ./rm_repo_of_aur.sh
    elif [ $2 != "" ]
    then
        echo "Invalid Arguments, exiting ..."
        exit 0
    fi
fi

aur_packages=$(cat $source_file)
repo_dir_name="local/repo"
done_aur_repo_name="packages_in_repo"
done_aur_repo_file_exists=0
gen_package=0

if [ -f "$done_aur_repo_name" ]
then
    echo "$done_aur_repo_name exists."
    done_aur_repo_file_exists=1
fi

mkdir -p $repo_dir_name
mkdir -p aur_tmp_build_dir
cd aur_tmp_build_dir
echo "##########################"
echo "# Creating Local Repo ####"
echo "##########################"
for package in $aur_packages
do
    gen_package=1

    if [ $done_aur_repo_file_exists = 1 ]
    then
        if $(grep -q "$package" ../"$done_aur_repo_name")
        then
            echo "$package already exists in repo"
            gen_package=0
        fi
    fi

    if [ $gen_package = 1 ]
    then
        echo -n "Adding $package ... "
        echo -n "(Clone "
        git clone https://aur.archlinux.org/$package.git &> /dev/null
        echo -n "OK) "
        cd $package
        echo -n "(PKG "
        if [ "$3" = "--debug" ]
        then
            makepkg
        else
            if [ "$2" = "--debug" ]
            then
                makepkg
            else
                makepkg > /dev/null 2>&1
            fi
        fi
        echo -n "OK) "
        count=`ls -1 *zst 2>/dev/null | wc -l`
        if [ $count != 0 ]
        then
            cp *.zst ../../$repo_dir_name
            cd ..
            repo-add ../local/repo/custom.db.tar.gz ../local/repo/$package*.zst > /dev/null
            echo "$package" >> ../$done_aur_repo_name
            echo "Done"
        else
            cd ..
            echo "Failed"
            rm -rf $package
        fi
    fi
done
