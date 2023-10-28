#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export RPC_URL="http://localhost:5050";

export WORLD_ADDRESS="0x5ac3d4b630c01b2e349f0f6266528e4a2e01ab5c07253cf5ecfc790cffe8a7f"

export ERC_ADDRESS="0x72895186e1c4dd4bdd77a860c429bd61597933d139c840432b181632e0f1d90"

echo "---------------------------------------------------------------------------"
echo world : $WORLD_ADDRESS 
echo " "
echo actions : $ERC_ADDRESS
echo "---------------------------------------------------------------------------"

# enable system -> component authorizations
COMPONENTS=("ERC20Balance", "ERC20Allowance", "ERC20Meta")

for component in ${COMPONENTS[@]}; do
    sozo auth writer $component $ERC_ADDRESS --world $WORLD_ADDRESS --rpc-url $RPC_URL
done

echo "Default authorizations have been successfully set."