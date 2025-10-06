# eproto

This repo serves as the single point of truth for Protocol Buffers definitions and code generation.

Intended usage for now is:

- Add this repo as a git submodule to your project
- Use the provided Docker image to generate code
- Consume the generated code for your desired language

## Quick start

### Add eproto as a submodule

Add this repo as a submodule:

```console
git submodule add https://github.com/enda-automation/eproto.git external/eproto
git commit -m "chore: add eproto submodule"
```

### Generate code

Fetch submodules and run the `eproto` Docker image to generate code:

```console
docker run --rm -v $(pwd)/external/eproto:/workspace ghcr.io/enda-automation/eproto:latest
```

If everything is set up correctly, you should see generated code in `external/eproto/gen` folder.

### Use generated code

Do not make modifications to this folder as it will be cleared on next generation.

If necessary write a script to move the files wherever you need them in your project.

### Example scripts to copy files to your project:

Example scripts to copy Go files to your project:

#### Bash

```bash
#!/bin/bash
set -e
# Pull latest changes for eproto submodule
git submodule update --remote external/eproto
# Regenerate code
docker run --rm -v $(pwd)/external/eproto:/workspace ghcr.io/enda-automation/eproto:latest
# Copy generated files to your project
mkdir -p pkg/eproto
cp -fr external/eproto/gen/go/* pkg/eproto/
```

#### Taskfile

```Taskfile
  protogen:
    # Depends on your taskfile location
    dir: ../../../
    generates:
      - pkg/eproto/*
    cmds:
      - git submodule update --remote external/eproto
      - docker run --rm -v $(pwd)/external/eproto:/workspace ghcr.io/enda-automation/eproto:latest
      - mkdir -p go/pkg/eproto
      - cp -fr external/eproto/gen/go/* go/pkg/eproto/
```

As a final escape hatch, you can pass additional arguments to `buf generate` command. For example, to regenerate only Go code:

```console
docker run --rm -v $(pwd):/workspace -w /workspace ghcr.io/enda-automation/eproto:latest buf generate --template "{plugins: [{local: 'protoc-gen-go', out: 'gen/go/pkg/egate-proto', opt: ['paths=import', 'module=enda/pkg/egate-proto'], include_imports: true}]}"
```

## Update

```console
git submodule update --remote external/eproto
git add external/eproto
git commit -m "Update eproto submodule"
```

```console
cd external/eproto
git pull origin main  # or whatever the default branch is
cd ../..
git add external/eproto
git commit -m "Update eproto submodule"
```

## Development

`buf` tool is used to generate code.

`buf.gen.yaml` controls generation. Local tools are preferred with respect to remote plugins because you can hit rate limits for remote plugins.

To install `buf` tool, follow instructions at https://buf.build/docs/cli/installation/ or use the provided Docker image.

## Docker image

Docker image is used to pin down known versions of required toolchain and is automatically built and published to GitHub Container Registry on every push to `main` branch.

See docker file for pinned versions.

Image is available at `ghcr.io/enda-automation/eproto:latest` and can be used as described in the Usage section.

To make updates on the Docker image, locally build the image with:

```console
docker build -t eproto .
```

And test it with:

```console
docker run --rm -v $(pwd):/workspace  eproto
```
