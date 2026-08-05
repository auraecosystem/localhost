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
  new URL("https://example.net/app"), 
  "https://example.net/manifest.json#appid"
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

# API Reference

## Discovery Document

For Discovery Document Resource details, see the [resource representation](https://developers.google.com/discovery/v1/reference/apis#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [list](https://developers.google.com/discovery/v1/reference/apis/list) | `GET /apis` | Retrieve the list of APIs supported at this endpoint. |

\* Relative to the base URI: https://discovery.googleapis.com/discovery/v1


# API Reference

This API reference is organized by resource type. Each resource type has one or more data representations and one or more methods.

## Bookshelf

For Bookshelf Resource details, see the [resource representation](https://developers.google.com/books/docs/v1/reference/bookshelves#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [list](https://developers.google.com/books/docs/v1/reference/bookshelves/list) | `GET /users/userId/bookshelves` | Retrieves a list of public [Bookshelf resource](https://developers.google.com/books/docs/v1/reference/bookshelves) for the specified user. |
| [get](https://developers.google.com/books/docs/v1/reference/bookshelves/get) | `GET /users/userId/bookshelves/shelf` | Retrieves a specific [Bookshelf resource](https://developers.google.com/books/docs/v1/reference/bookshelves) for the specified user. |

\* Relative to the base URI: https://www.googleapis.com/books/v1

## Volume

For Volume Resource details, see the [resource representation](https://developers.google.com/books/docs/v1/reference/volumes#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [get](https://developers.google.com/books/docs/v1/reference/volumes/get) | `GET /volumes/volumeId` | Retrieves a [Volume resource](https://developers.google.com/books/docs/v1/reference/volumes) based on ID. |
| [list](https://developers.google.com/books/docs/v1/reference/volumes/list) | `` GET /volumes?q=`{search terms}` `` | Performs a book search. |

\* Relative to the base URI: https://www.googleapis.com/books/v1

## Bookshelves.volumes

For Bookshelves.volumes Resource details, see the [resource representation](https://developers.google.com/books/docs/v1/reference/bookshelves/volumes#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [list](https://developers.google.com/books/docs/v1/reference/bookshelves/volumes/list) | `GET /users/userId/bookshelves/shelf/volumes` | Retrieves volumes in a specific bookshelf for the specified user. |

\* Relative to the base URI: https://www.googleapis.com/books/v1

## Mylibrary.bookshelves

For Mylibrary.bookshelves Resource details, see the [resource representation](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [addVolume](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/addVolume) | `POST /mylibrary/bookshelves/shelf/addVolume` | Adds a volume to a bookshelf. |
| [clearVolumes](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/clearVolumes) | `POST /mylibrary/bookshelves/shelf/clearVolumes` | Clears all volumes from a bookshelf. |
| [get](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/get) | `GET /mylibrary/bookshelves/shelf` | Retrieves metadata for a specific bookshelf belonging to the authenticated user. |
| [list](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/list) | `GET /mylibrary/bookshelves` | Retrieves a list of bookshelves belonging to the authenticated user. |
| [moveVolume](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/moveVolume) | `POST /mylibrary/bookshelves/shelf/moveVolume` | Moves a volume within a bookshelf. |
| [removeVolume](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/removeVolume) | `POST /mylibrary/bookshelves/shelf/removeVolume` | Removes a volume from a bookshelf. |

\* Relative to the base URI: https://www.googleapis.com/books/v1

## Mylibrary.bookshelves.volumes

For Mylibrary.bookshelves.volumes Resource details, see the [resource representation](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/volumes#resource) page.

| Method | REST URI \* | Description |
|---|---|---|
| [list](https://developers.google.com/books/docs/v1/reference/mylibrary/bookshelves/volumes/list) | `GET /mylibrary/bookshelves/shelf/volumes` | Gets volume information for volumes on a bookshelf. |

\* Relative to the base URI: https://www.googleapis.com/books/v1
```yaml
{
  "kind": "discovery#restDescription",
  "discoveryVersion": "v1",
  "id": string,
  "name": string,
  "canonicalName": string,
  "version": string,
  "revision": string,
  "title": string,
  "description": string,
  "icons": {
    "x16": string,
    "x32": string
  },
  "documentationLink": string,
  "labels": [
    string
  ],
  "protocol": "rest",
  "baseUrl": string,
  "basePath": string,
  "rootUrl": string,
  "servicePath": string,
  "batchPath": "batch",
  "endpoints": [
    {
      "endpointUrl": string,
      "location": string,
      "deprecated": boolean,
      "description": string
    }
  ],
  "parameters": {
    (key): {
      "id": string,
      "type": string,
      "$ref": string,
      "description": string,
      "default": string,
      "required": boolean,
      "format": string,
      "pattern": string,
      "minimum": string,
      "maximum": string,
      "enum": [
        string
      ],
      "enumDescriptions": [
        string
      ],
      "repeated": boolean,
      "location": string,
      "properties": {
        (key): (JsonSchema)
      },
      "additionalProperties": (JsonSchema),
      "items": (JsonSchema),
      "annotations": {
        "required": [
          string
        ]
      }
    }
  },
  "auth": {
    "oauth2": {
      "scopes": {
        (key): {
          "description": string
        }
      }
    }
  },
  "features": [
    string
  ],
  "schemas": {
    (key): {
      "id": string,
      "type": string,
      "$ref": string,
      "description": string,
      "default": string,
      "required": boolean,
      "deprecated": boolean,
      "format": string,
      "pattern": string,
      "minimum": string,
      "maximum": string,
      "enum": [
        string
      ],
      "enumDescriptions": [
        string
      ],
      "enumDeprecated": [
        boolean
      ],
      "repeated": boolean,
      "location": string,
      "properties": {
        (key): (JsonSchema)
      },
      "additionalProperties": (JsonSchema),
      "items": (JsonSchema),
      "annotations": {
        "required": [
          string
        ]
      }
    }
  },
  "methods": {
    (key): {
      "id": string,
      "path": string,
      "httpMethod": string,
      "description": string,
      "deprecated": boolean,
      "parameters": {
        (key): {
          "id": string,
          "type": string,
          "$ref": string,
          "description": string,
          "default": string,
          "required": boolean,
          "deprecated": boolean,
          "format": string,
          "pattern": string,
          "minimum": string,
          "maximum": string,
          "enum": [
            string
          ],
          "enumDescriptions": [
            string
          ],
          "enumDeprecated": [
            boolean
          ],
          "repeated": boolean,
          "location": string,
          "properties": {
            (key): (JsonSchema)
          },
          "additionalProperties": (JsonSchema),
          "items": (JsonSchema),
          "annotations": {
            "required": [
              string
            ]
          }
        }
      },
      "parameterOrder": [
        string
      ],
      "request": {
        "$ref": string
      },
      "response": {
        "$ref": string
      },
      "scopes": [
        (value)
      ],
      "supportsMediaDownload": boolean,
      "supportsMediaUpload": boolean,
      "mediaUpload": {
        "accept": [
          string
        ],
        "maxSize": string,
        "protocols": {
          "simple": {
            "multipart": true,
            "path": string
          },
          "resumable": {
            "multipart": true,
            "path": string
          }
        }
      },
      "supportsSubscription": boolean
    }
  },
  "resources": {
    (key): {
      "methods": {
        (key): {
          "id": string,
          "path": string,
          "httpMethod": string,
          "description": string,
          "deprecated": boolean,
          "parameters": {
            (key): {
              "id": string,
              "type": string,
              "$ref": string,
              "description": string,
              "default": string,
              "required": boolean,
              "deprecated": boolean,
              "format": string,
              "pattern": string,
              "minimum": string,
              "maximum": string,
              "enum": [
                string
              ],
              "enumDescriptions": [
                string
              ],
              "enumDeprecated": [
                boolean
              ],
              "repeated": boolean,
              "location": string,
              "properties": {
                (key): (JsonSchema)
              },
              "additionalProperties": (JsonSchema),
              "items": (JsonSchema),
              "annotations": {
                "required": [
                  string
                ]
              }
            }
          },
          "parameterOrder": [
            string
          ],
          "request": {
            "$ref": string
          },
          "response": {
            "$ref": string
          },
          "scopes": [
            (value)
          ],
          "supportsMediaDownload": boolean,
          "supportsMediaUpload": boolean,
          "mediaUpload": {
            "accept": [
              string
            ],
            "maxSize": string,
            "protocols": {
              "simple": {
                "multipart": true,
                "path": string
              },
              "resumable": {
                "multipart": true,
                "path": string
              }
            }
          },
          "supportsSubscription": boolean
        }
      },
      "deprecated": boolean,
      "resources": {
        (key): (RestResource)
      }
    }
  }
}
```
