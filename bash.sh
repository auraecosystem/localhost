mkdir my_agent\
type nul > my_agent\agent.go
type nul > my_agent\env.bat
mkdir -p my_agent/ && \
    touch my_agent/agent.go && \
    touch my_agent/.env
git clone https://github.com/localgpt-app/localgpt.git
cd localgpt

# World Building
cargo run -p localgpt-gen -- "Create a desert scene with pyramids"

# AI Assistant
cargo run -- chat
cargo run -- daemon start
bun install --frozen-lockfile
bun run typecheck
bun test
bun run build
npm install --save-dev @workos/emulate

# or run without installing
npx @workos/emulate
LocalSettings.php:
$wgDnsBlacklistUrls = array(
        'all.s5h.net.',
);
#!/bin/bash

LOG=/var/tmp/my_script_${HOSTNAME}_$$_${USER}.log

exec 2>&1 1>${LOG}
$ my_script 2>&1 > /var/tmp/my_script_${HOSTNAME}_$$_${USER}.log
You
$ [alt-10]a
$ aaaaaaaaaa
# macOS (Apple Silicon)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-darwin-arm64
chmod +x workos-emulate

# macOS (Intel)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-darwin-x64
chmod +x workos-emulate

# Linux with glibc (x64)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-linux-x64
chmod +x workos-emulate

# Linux with glibc (arm64)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-linux-arm64
chmod +x workos-emulate

# Alpine Linux / musl (x64)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-linux-x64-musl
chmod +x workos-emulate

# Alpine Linux / musl (arm64)
curl -fsSL -o workos-emulate https://github.com/workos/emulate/releases/latest/download/workos-emulate-linux-arm64-musl
chmod +x workos-emulate
curl -s http://localhost:4100/oauth2/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d grant_type=client_credentials \
  -d client_id=client_local_backend \
  -d client_secret=secret_local_backend
# (client credentials may also be sent via HTTP Basic auth)
# The seeded value authenticates requests:
curl http://localhost:4100/connect/applications -H "Authorization: Bearer sk_test_ci_key"
curl -X POST http://localhost:4100/webhook_endpoints \
  -H "Authorization: Bearer sk_test_default" \
  -H "Content-Type: application/json" \
  -d '{"endpoint_url":"http://localhost:8000/webhooks","secret":"whsec_test","events":[]}'
curl -X POST http://localhost:4100/user_management/authenticate \
  -H "Content-Type: application/json" \
  -d '{"grant_type":"urn:workos:oauth:grant-type:organization-selection","pending_authentication_token":"pending_...","organization_id":"org_..."}'
  curl -X PUT http://localhost:4100/user_management/jwt_template \
  -H "Authorization: Bearer sk_test_default" \
  -H "Content-Type: application/json" \
  -d '{"content": "{\"urn:my-webapp:tenant\": \"{{ organization.metadata.tenant_id }}\"}"}'
  # List all hooks
curl http://localhost:4100/_emulate/hooks

# Add a hook
curl -X POST http://localhost:4100/_emulate/hooks \
  -H "Content-Type: application/json" \
  -d '{"method":"GET","path":"/user_management/users","status":500}'

# Remove a hook by ID
curl -X DELETE http://localhost:4100/_emulate/hooks/hook_abc123
  
