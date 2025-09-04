#!/bin/bash
set -e

NAMESPACE="app"
DEPLOY="was-app"
REPO="ghcr.io/soloud1025/soloud-was"

echo "=== 1) 현재 Deployment에 설정된 이미지 확인 ==="
DEPLOY_IMAGE=$(kubectl -n $NAMESPACE get deploy $DEPLOY -o jsonpath='{.spec.template.spec.containers[0].image}')
echo "Deployment image: $DEPLOY_IMAGE"

echo
echo "=== 2) 실제 실행 중인 Pods 이미지 확인 ==="
kubectl -n $NAMESPACE get pods -l app=was -o jsonpath='{range .items[*]}{.metadata.name}{" -> "}{.spec.containers[0].image}{"\n"}{end}'

echo
echo "=== 3) GHCR 최신 이미지 목록 가져오기 (상위 5개) ==="
curl -s -H "Accept: application/vnd.github+json" \
  https://ghcr.io/v2/soloud1025/soloud-was/tags/list \
  | jq '.tags[:5]'

echo
echo "=== 4) 배포된 이미지가 GHCR에 존재하는지 확인 ==="
DEPLOY_TAG=$(echo $DEPLOY_IMAGE | awk -F: '{print $2}')
if curl -s -H "Accept: application/vnd.github+json" \
  https://ghcr.io/v2/soloud1025/soloud-was/manifests/$DEPLOY_TAG \
  | grep -q "schemaVersion"; then
  echo "✅ 배포 이미지 태그 [$DEPLOY_TAG] 는 GHCR에 존재합니다."
else
  echo "❌ 배포 이미지 태그 [$DEPLOY_TAG] 는 GHCR에 없음."
fi

