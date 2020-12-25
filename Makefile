PROTO_SRCS = $(wildcard *.proto)

PROTO_PY2S = $(patsubst %.proto,proto_py/%_pb2.py,$(PROTO_SRCS))

all: proto-gen

clean:
	rm -rf output/*

py-dependencies:
	$(PYTHON) -m pip install grpcio-tools googleapis-common-protos twine setuptools

dependencies:  py-dependencies

proto_py:
	mkdir -p output

$(PROTO_PY2S): $(PROTO_SRCS) | proto_py
	$(PYTHON) -m grpc_tools.protoc \
		--proto_path=./ \
		--python_out=proto_py \
		--grpc_python_out=proto_py *.proto 

proto-gen : $(PROTO_PY2S)

.PHONY: clean all dependencies proto-gen
## Commons Vars ########################################################################################################


PYTHON ?= python
GIT ?= git
COMMIT := $(shell $(GIT) rev-parse HEAD)
PREV_COMMIT := $(shell $(GIT) rev-parse HEAD~)
