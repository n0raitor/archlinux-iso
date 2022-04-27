#!/bin/bash

###################################
# Generate Local Repo for ArchISO #
###################################

source_file="./aur_packages_big"  # Do not enter # Symbols (no # Skipping included
aur_packages=$(cat $source_file)
repo_dir_name="local/repo"

mkdir -p $repo_dir_name
mkdir -p aur_tmp_build_dir
cd aur_tmp_build_dir
echo "##########################"
echo "# Creating Local Repo ####"
echo "##########################"
for package in $aur_packages
do
    echo -n "Adding $package ... "
    echo -n "(Clone "
    git clone https://aur.archlinux.org/$package.git &> /dev/null
    echo -n "OK) "
    cd $package
    echo -n "(PKG "
    makepkg &> /dev/null
    echo -n "OK) "
    count=`ls -1 *zst 2>/dev/null | wc -l`
    if [ $count != 0 ]
    then
        cp *.zst ../../$repo_dir_name
        cd ..
        repo-add ../local/repo/custom.db.tar.gz ../local/repo/$package*.zst > /dev/null
        echo "Done"
    else
        cd ..
        echo "Failed"
    fi
done
