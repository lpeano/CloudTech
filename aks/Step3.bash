export TF_VAR_ARM_SUBSCRIPTION_ID="4703f74e-f898-4a9f-959f-2477c1f0c17c"
export TF_VAR_ARM_TENANT_ID="$(cat $1 |jq '.tenant')"
export TF_VAR_ARM_CLIENT_ID="$(cat $1|jq '.appId')"
export TF_VAR_ARM_CLIENT_SECRET="$(cat $1|jq '.password')"
