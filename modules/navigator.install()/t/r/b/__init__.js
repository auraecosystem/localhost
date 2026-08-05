// 2. Install a specific web app via URL and manifest ID
await navigator.install(
  new URL("https://example.net/app"), 
  "https://example.com/manifest.json#appid"
);
