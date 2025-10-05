#!/bin/bash
source $NVM_DIR/nvm.sh
cd protos/
buf generate "$@"
