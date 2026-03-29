#!/bin/sh
set -eu

out_file="${1:-.env}"

if [ -e "$out_file" ]; then
    echo "$out_file already exists" >&2
    exit 1
fi

api_key="sk-$(openssl rand -base64 36 | tr -dc 'A-Za-z0-9' | head -c 48)"

cat > "$out_file" <<EOF
LLM_API_KEY=$api_key
EOF

echo "Wrote $out_file"
