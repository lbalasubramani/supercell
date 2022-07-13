#!/bin/bash
while getopts ":d:" opt; do
  case ${opt} in
    d )
        opa_dir=$OPTARG;;
    \? ) echo "Usage: ./opa-validate.sh [-d]"
      ;;
  esac
done

for i in $( cat ${opa_dir}/values.yaml | yq r - --printMode p "opa.bootstrapPolicies.*")
    do
        cat ${opa_dir}/values.yaml| yq r - --printMode v "$i" > ${opa_dir}/tests/$i.rego
    done

if [[ $(opa test ${opa_dir}/tests --explain=notes) ]];then
    echo "All tests passed";
else
    echo "One or more tests failed";exit 1;fi  
