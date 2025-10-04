# eproto

This repo serves as the single point of truth for Protocol Buffers definitions and code generation for enda services.

Intended usage for now is:

- Add this repo as a git submodule to your project
- Use the provided Docker image to generate code
- Consume the generated code for your desired language

## Usage

Add this repo as a submodule:

```console
git submodule add https://github.com/enda-automation/eproto.git libs/eproto
```

Fetch submodules and run the `eproto` Docker image to generate code:

```console
git submodule update --init --recursive
cd libs/eproto
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/enda-automation/eproto:latest
```

If everything is set up correctly, you should see generated code in `gen` folder.

As a final escape hatch, you can pass additional arguments to `buf generate` command. For example, to regenerate only Go code:

```console
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/enda-automation/eproto:latest buf generate --template "{plugins: [{local: 'protoc-gen-go', out: 'gen/go/pkg/egate-proto', opt: ['paths=import', 'module=enda/pkg/egate-proto'], include_imports: true}]}"
```

## Development

`buf` tool is used to generate code.

`buf.gen.yaml` controls generation. Local tools are preferred with respect to remote plugins because you can hit rate limits for remote plugins.

To install `buf` tool, follow instructions at https://buf.build/docs/cli/installation/.