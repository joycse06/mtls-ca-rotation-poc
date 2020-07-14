#!/usr/bin/env bash

set -eu

timestamp=$(date +%s)
default_tag="tag-$timestamp"
ensured_tag=${TAG:-$default_tag}
echo "Image will be tagged with: $ensured_tag"

echo "Building docker image..."
docker build ./consul-template \
  -t  joycse06/consul-template-with-ruby:"$ensured_tag" \
  -f consul-template/Dockerfile \
  --build-arg vault_addr="http://vault:8200" \
  --build-arg consul_address="http://consul:8500" \
  --build-arg vault_token="root" \
  --build-arg pki_consul_root_key="pki/root" \
  --build-arg pki_output_path="/app/consul-template/output" \
  --build-arg pki_certificate_issue_role="issuer" \
  --build-arg pki_ttl="1m" \

echo "Pushing to Docker Hub..."

docker push joycse06/consul-template-with-ruby:"$ensured_tag"
