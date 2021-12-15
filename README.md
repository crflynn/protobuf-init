# protobuf-init

To install:

```bash
pip install protobuf-init
```

This package will create `__init__.py` files when compiling `*.proto` files. Optionally, it will create relative imports from generated `*_pb.py`, `*_pb_grpc.py`, and `*_grpc.py` files from `protobuf`, `grpcio`, and `grpclib` packages, respectively.

Using the `protos` folder of this project as an example, the following command will generate the contents of the `example` package, also in this project (assuming `grpcio-tools` is installed):

```bash
export PROTO_PATH=./protos
export GEN_PATH=.
python -m grpc_tools.protoc \
    --python_out=$GEN_PATH \
    --mypy_out=$GEN_PATH \
    --init_python_out=$GEN_PATH \
    --init_python_opt=imports=protobuf+grpcio+grpclib \
    --grpc_python_out=$GEN_PATH \
    --grpclib_python_out=$GEN_PATH \
    --proto_path=$PROTO_PATH 
    $(find $PROTO_PATH -name '*.proto')
```

The `--init_python_out=$GEN_PATH` flag indicates to call the plugin to create the init files.

The `--init_python_opt=imports=protobuf+grpcio+grpclib` indicates which relative imports to include in the init files. Allowed options are `protobuf`, `grpcio`, `grpclib`, separated by `+`. (Note that both grpcio and grpclib generate `<ServiceName>Stub` objects which would collide in the init file.)