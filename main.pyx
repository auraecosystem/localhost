import workos

workos.api_key = "sk_test_default"
workos.base_url = "http://localhost:8000"  # ← emulator

# Use the SDK as normal — requests hit the emulator
user = workos.client.user_management.create_user(email="make.universal@example.com")

# Add an error hook at runtime to test failure handling
import requests

requests.post("http://localhost:4100/_emulate/hooks", json={
    "method": "POST",
    "path": "/user_management/users",
    "status": 422,
    "body": {"message": "Validation failed", "code": "unprocessable_entity"},
})

# Now this call returns a 422 — test your error handling
try:
    workos.client.user_management.create_user(email="you@example.com")
except Exception as e:
    print(f"Handled error: {e}")
