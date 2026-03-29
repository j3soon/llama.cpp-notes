# DGX Spark Local llama.cpp

Runs `llama.cpp` behind a minimal NGINX reverse proxy with a static Bearer token. No HTTPS yet.

## Setup

```sh
cd examples/dgx-spark
mkdir -p ../../models
./scripts/gen_env.sh
cat .env
docker compose up -d
```

## Test

```sh
LLM_API_KEY='<value from .env>'
curl http://127.0.0.1:37000/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $LLM_API_KEY" \
  -d '{
    "messages": [
      {"role": "user", "content": "Hello"}
    ]
  }'
```

`llm` is private on the Compose network. NGINX is the only published port.

Remote clients can access only `/v1/chat/completions`. Full access remains available from localhost.

Edit [`compose.yaml`](./compose.yaml) if you want a different model or host port. Edit [`nginx.conf`](./nginx.conf) if you want to change the proxy behavior.
