#!/bin/bash

if [ "$#" -ne 1 ]
then
  echo "please provide the following parameters: "
  echo "start | stop"
  exit 1
fi

command=$1
for machine in $(azure vm list --json | jq -r '.[] | .resourceGroupName+ "---" + .name')
do
   group=`echo $machine | sed 's/---.*$//'`
   name=`echo $machine | sed 's/^.*---//'`
   if [[ $name != "buildmachine" ]]
   then
     echo "stopping machine in resourcegroup $group with name $name"
     azure vm $command $group $name
   fi
done
