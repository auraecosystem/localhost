The **Web Install API** (implemented in Chromium under `third_party/blink/renderer/modules/web_install/`) allows web applications or app-store sites to trigger the installation of a Progressive Web App (PWA).

How it works depends on whether you are **testing/using the API as a developer** or **compiling the Chromium engine**.

---

## 1. Web Developers: Using `navigator.install()`

The API provides programmatic installation without relying on legacy events like `beforeinstallprompt`.

### JavaScript Usage

```javascript
// Check if the Web Install API is supported
if ('install' in navigator) {
  try {
    // 1. Install the current site as a PWA
    await navigator.install();
    console.log("App installed successfully!");
  } catch (err) {
    console.error("Installation failed or was rejected:", err);
  }
}

```

You can also pass arguments to install another page or application from a supported origin:

```javascript
// 2. Install a specific web app via URL and manifest ID
await navigator.install(
  new URL("https://example.com/app"), 
  "https://example.com/manifest.json#appid"
);

```

### Enabling the Feature Flag

Since the API is experimental across Chromium browsers (Chrome/Edge):

1. Open **`chrome://flags`** (or `edge://flags`) in your browser.
2. Search for **Web App Installation API** (or `#web-app-installation-api`).
3. Set it to **Enabled** and restart the browser.

---

## 2. Browser Engine Developers: Building the Blink Module

If you are modifying the [Chromium C++ codebase directly ](`third_party/blink/renderer/modules/web_install/`):

### Build Configuration (`args.gn`)

Ensure Web App installation flags are active in your Chromium build target:

```gn
# Enable experimental Web Platform features in your build
enable_web_app_installation = true

```

### Module Architecture in Chromium

When `navigator.install()` is called in JavaScript:

1. [**Blink Renderer ](`modules/web_install/`)**: `navigator_web_install.cc` validates the request (e.g., checks if triggered by a user gesture).
2.[ **Mojo IPC ](`web_install.mojom`)**: The request is passed from Blink to the browser process via a Mojo interface.
3.[ **Browser Process ](`//chrome/browser/web_applications/`)**: `web_install_service_impl.cc` fetches the app manifest, checks permissions, and presents the native installation dialog to the user.
