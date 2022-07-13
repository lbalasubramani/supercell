#!/bin/bash
while getopts ":p:r:s:k:" opt; do
  case ${opt} in
    p )
        ARGOCD_PASSWORD=$OPTARG;;
    r ) 
        REPOSITORY_SECRET=$( echo $OPTARG );;
    s ) 
        SLACK_TOKEN=$( echo $OPTARG | jq .token | tr -d '"');;
    k ) 
        EKS_CLUSTER_NAME=$OPTARG;;
    \? ) echo "Usage: argocd-setup.sh [-p] [-r] [-s] [-k]"
      ;;
  esac
done

cat <<EOF | kubectl apply -f -
kind: Namespace
apiVersion: v1
metadata:
  name: argocd
EOF

REPOSITORY_TOKEN=$( echo $REPOSITORY_SECRET | jq .token | tr -d '"')
REPOSITORY_USER=$( echo $REPOSITORY_SECRET | jq .username | tr -d '"')

kubectl apply -n argocd -k ./k8s_components/argocd/overlays/${EKS_CLUSTER_NAME}
kubectl -n argocd patch secret argocd-secret -p '{"stringData":{"admin.password":"'$(htpasswd -bnBC 10 "" $ARGOCD_PASSWORD | tr -d ':\n')'","admin.passwordMtime":"'$(date +%FT%T%Z)'"}}'
kubectl -n argocd patch secret argocd-notifications-secret -p '{"stringData":{"slack-token":"'$SLACK_TOKEN'"}}'
if [[ $( kubectl get secret github-token -n argocd 2>/dev/null) ]];then 
    echo "Secrets github_token already exists";
else 
    kubectl create secret generic -n argocd github-token --from-literal=token=$REPOSITORY_TOKEN --from-literal=username=$REPOSITORY_USER;fi
