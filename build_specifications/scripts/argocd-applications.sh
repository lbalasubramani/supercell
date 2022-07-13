#!/bin/bash
while getopts ":o:e:d:k:" opt; do
  case ${opt} in
    o )
        OUTPUT_FILE=$OPTARG;;
    e ) 
        ENVIRONMENT=$OPTARG;;
    d ) 
        DIR=$OPTARG;;
    k ) 
        CLUSTER_NAME=$OPTARG;;
    \? ) echo "Usage: argocd-applications.sh [-o] [-e] [-d] [-k]"
      ;;
  esac
done

export INGRESS_NGINX_ACM_CERTIFICATE_ARN=$(cat $OUTPUT_FILE | jq -r .ingress_nginx_acm_certificate_arn.value)
export INGRESS_NGINX_DOMAIN_NAME=$(cat $OUTPUT_FILE | jq -r .ingress_nginx_domain_name.value)
export R53_HOSTED_ZONE_ID=$(cat $OUTPUT_FILE | jq -r .r53_hosted_zone_id.value)
export EXTERNAL_DNS_ROLE_ARN=$(cat $OUTPUT_FILE | jq -r .external_dns_role_arn.value)
export VELERO_ROLE_ARN=$(cat $OUTPUT_FILE | jq -r .velero_role_arn.value)
if [ "$ENVIRONMENT" = "nonprod" ]; then
    export PAGER_DUTY_SERVICE_KEY_GOLD_WARNING=$( echo $PAGER_DUTY_SERVICE_KEY_GOLD_WARNING | jq .integration_key | tr -d '"')
elif [ "$ENVIRONMENT" = "prod" ];then
    export PAGER_DUTY_SERVICE_KEY_GOLD_WARNING=$( echo $PAGER_DUTY_SERVICE_KEY_GOLD_WARNING | jq .integration_key | tr -d '"')
    export PAGER_DUTY_SERVICE_KEY_GOLD_CRITICAL=$( echo $PAGER_DUTY_SERVICE_KEY_GOLD_CRITICAL | jq .integration_key | tr -d '"')
else
    echo "$ENVIRONMENT is not correct."
    exit 1
fi

kubectl apply -f ./build_specifications/gp2-encrypted.yaml
kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.beta.kubernetes.io/is-default-class":"false","storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch storageclass gp2-encrypted -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
envsubst < ${DIR}/prometheus/cluster-configs/${ENVIRONMENT}-values.yaml.tpl > ${ENVIRONMENT}-values.yaml && kubectl apply -f ${ENVIRONMENT}-values.yaml
envsubst < ${DIR}/argocd/argocd-cm.yaml.tpl > argocd-cm.yaml && kubectl apply -f argocd-cm.yaml
envsubst < ${DIR}/argocd/applications/base/applications.yaml.tpl > ${DIR}/argocd/applications/base/applications.yaml && \
kubectl apply -k ${DIR}/argocd/applications/overlays/${CLUSTER_NAME}