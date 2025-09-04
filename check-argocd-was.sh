#!/bin/bash
set -e

APP_NAME="was-app"
NAMESPACE="app"
ARGO_APP="was-app"
ARGO_NS="argocd"

echo "=== 1) ArgoCD Application 상태 확인 ==="
kubectl -n $ARGO_NS get application $ARGO_APP -o wide

echo
echo "=== 2) 최신 Revision 확인 ==="
LATEST_REV=$(kubectl -n $ARGO_NS get application $ARGO_APP -o jsonpath='{.status.sync.revision}')
echo "Latest Git revision: $LATEST_REV"

echo
echo "=== 3) Deployment 이미지 확인 ==="
DEPLOY_IMG=$(kubectl -n $NAMESPACE get deploy $APP_NAME -o jsonpath='{.spec.template.spec.containers[0].image}')
echo "Deployment image: $DEPLOY_IMG"

echo
echo "=== 4) 현재 실행 중인 Pods ==="
kubectl -n $NAMESPACE get pods -o wide -l app=was

echo
echo "=== 5) Pod 별 실제 이미지 태그 ==="
kubectl -n $NAMESPACE get pods -l app=was -o jsonpath='{range .items[*]}{.metadata.name}{" -> "}{.spec.containers[0].image}{"\n"}{end}'

echo
echo "=== 6) Health 체크 (readinessProbe 기준) ==="
kubectl -n $NAMESPACE get pods -l app=was -o jsonpath='{range .items[*]}{.metadata.name}{" : "}{.status.containerStatuses[0].ready}{"\n"}{end}'

