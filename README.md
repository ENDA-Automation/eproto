# eproto

`buf` tool is used to generate code.

`buf.gen.yaml` controls generation. Local tools are preferred with respect to remote plugins because you can hit rate limits for remote plugins.

## Usage

```console
git submodule add https://github.com/enda-automation/eproto.git libs/eproto
```

```console
git submodule update --init --recursive
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/enda-automation/eproto:latest
```

## Install buf

```console
go install github.com/bufbuild/buf/cmd/buf@v1.57.2
```

## Required tools in PATH

### protoc-gen-go

```console
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.10
```

### protoc-gen-nanopb

```console
brew install nanopb
```

Developed with 0.4.9.1

### protoc-gen-ts_proto

```console
npm install -g ts-proto
export PATH="$PATH:$(npm bin -g)"
```

```console
protoc --version
libprotoc 32.1
```console
