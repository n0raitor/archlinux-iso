#!/bin/bash

done_aur_repo_name="packages_in_repo"

DIR="local/repo"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -n "Removing local/repo folder... "
  sudo rm -rf local/repo
  echo "Done"
fi

DIR="aur_tmp_build_dir"
if [ -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo -n "Removing aur_tmp_build_dir folder... "
  sudo rm -rf aur_tmp_build_dir
  echo "Done"
fi

if test -f "$done_aur_repo_name"; then
    echo -n "Removing state file... "
    rm -f $done_aur_repo_name
    echo "Done"
fi

echo "FINISHED"
