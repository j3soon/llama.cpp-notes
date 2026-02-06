# llama.cpp Notes

Minimal steps to run [llama.cpp](https://github.com/ggml-org/llama.cpp) in docker on NVIDIA GPUs.

## Pull the docker image

Follow the [official instructions](https://github.com/ggml-org/llama.cpp/blob/master/docs/docker.md):

```sh
# docker pull ghcr.io/ggml-org/llama.cpp:full-cuda
# docker pull ghcr.io/ggml-org/llama.cpp:light-cuda
docker pull ghcr.io/ggml-org/llama.cpp:server-cuda
```

## GPT-OSS

Follow the official instructions in the [discussion](https://github.com/ggml-org/llama.cpp/discussions/15396), the models will be downloaded to the `./models` directory:

```sh
# llama-server -hf ggml-org/gpt-oss-20b-GGUF  --ctx-size 0 --jinja -ub 2048 -b 2048
docker run --rm -it --gpus all --network=host \
  -v ./models:/root/.cache/llama.cpp \
  ghcr.io/ggml-org/llama.cpp:server-cuda \
  -hf ggml-org/gpt-oss-20b-GGUF \
  --ctx-size 0 --jinja -ub 2048 -b 2048
```

As mentioned in the discussion, the `gpt‑oss 20B` will take up to 18GB VRAM without offloading, while `gpt‑oss 120B` will take up to 69GB VRAM without offloading.
