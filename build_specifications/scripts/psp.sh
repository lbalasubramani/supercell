#!/bin/bash
while getopts ":d:" opt; do
  case ${opt} in
    d )
        psp_dir=$OPTARG;;
    \? ) echo "Usage: ./psp.sh [-d]"
      ;;
  esac
done

echo "Patching CoreDNS"
kubectl patch deployment coredns -n kube-system -p '{"spec":{"template":{"spec":{"containers":[{"name":"coredns","resources":{"limits":{"cpu":"200m","memory": "170Mi"}}}]}}}}'
kubectl patch deployment coredns -n kube-system -p '{"spec":{"template":{"spec":{"containers":[{"name":"coredns","resources":{"limits":{"cpu":"200m","memory": "170Mi"}}}]}}}}'
kubectl apply -f ${psp_dir}/create/
if [[ $(kubectl get -f ${psp_dir}/delete 2>/dev/null) ]];then 
    echo "Privileged resources exists.Deleting...";
    kubectl delete -f ${psp_dir}/delete/
else 
    echo "Privileged resources doesn't exist.";
fi