SHELL := /bin/bash
export PROTO_PATH=./protos
export GEN_PATH=.

gen:
	poetry run python -m grpc_tools.protoc \
		--python_out=$$GEN_PATH \
		--mypy_out=$$GEN_PATH \
		--init_python_out=$$GEN_PATH \
		--grpc_python_out=$$GEN_PATH \
		--grpclib_python_out=$$GEN_PATH \
		--proto_path=$$PROTO_PATH \
		$$(find $$PROTO_PATH -name '*.proto')
	make fmt

geni:
	poetry run python -m grpc_tools.protoc \
		--python_out=$$GEN_PATH \
		--mypy_out=$$GEN_PATH \
		--init_python_out=$$GEN_PATH \
		--init_python_opt=imports=protobuf+grpcio+grpclib \
		--grpc_python_out=$$GEN_PATH \
		--grpclib_python_out=$$GEN_PATH \
		--proto_path=$$PROTO_PATH \
		$$(find $$PROTO_PATH -name '*.proto')
	make fmt

clean:
	rm -rf ./example

fmt:
	poetry run isort .
	poetry run black .

publish:
	rm -rf dist
	poetry build
	poetry publish

release:
	rm -rf dist
	poetry build
	ghr -u crflynn -r protobuf-init -c $(shell git rev-parse HEAD) -delete -b "release" -n $(shell poetry version -s) $(shell poetry version -s) dist/*.tar.gz
