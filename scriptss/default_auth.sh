#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export RPC_URL="http://localhost:5050";

export WORLD_ADDRESS=$(cat ./target/dev/manifest.json | jq -r '.world.address')

export ERC20_ADDRESS=$(cat ./target/dev/manifest.json | jq -r '.contracts[] | select(.name == "erc20" ).address')

echo "---------------------------------------------------------------------------"
echo world : $WORLD_ADDRESS 
echo " "
echo erc20 : $ERC20_ADDRESS
echo "---------------------------------------------------------------------------"

# enable system -> component authorizations
COMPONENTS=("ERC20Balance" "ERC20Allowance" ERC20Meta)

for component in ${COMPONENTS[@]}; do
    sozo auth writer $component $ERC20_ADDRESS --world $WORLD_ADDRESS --rpc-url $RPC_URL
done

echo "Default authorizations have been successfully set."