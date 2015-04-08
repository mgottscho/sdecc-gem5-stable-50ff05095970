#!/bin/bash
#
# Author: Mark Gottscho
# Email: mgottscho@ucla.edu

protoc --python_out=./util --proto_path=src/proto src/proto/packet.proto
