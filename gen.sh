#!/bin/bash
source $NVM_DIR/nvm.sh
cd /workspace/protos/
buf generate "$@"
