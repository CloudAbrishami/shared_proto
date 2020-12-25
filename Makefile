PROTO_SRCS = $(wildcard *.proto)

PROTO_PY2S = $(patsubst %.proto,proto_py/%_pb2.py,$(PROTO_SRCS))

all: proto-gen

clean:
	rm -rf proto_py/*

py-dependencies:
	$(PYTHON) -m pip install grpcio-tools googleapis-common-protos twine setuptools

dependencies:  py-dependencies

proto_py:
	mkdir -p $@

$(PROTO_PY2S): $(PROTO_SRCS) | proto_py
	$(PYTHON) -m grpc.tools.protoc \
		--proto_path=proto_py \
		--python_out=proto_py \
		--grpc_python_out=proto_py *.proto 


.PHONY: clean all dependencies proto-gen
## Commons Vars ########################################################################################################


PYTHON ?= python
GIT ?= git
COMMIT := $(shell $(GIT) rev-parse HEAD)
PREV_COMMIT := $(shell $(GIT) rev-parse HEAD~)
