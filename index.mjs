"use strict";

const BASE =
    "https://page.net";

const MARKDOWN_SOURCES = {
    readme: `${BASE}/README.md`,
    mmd: `${BASE}/docs/mmd.md`,
};

const REQUEST_TIMEOUT = 10_000;

async function fetchMarkdown(url, signal) {
    const response = await fetch(url, {
        signal,
        headers: {
            Accept: "text/markdown,text/plain;q=0.9,*/*;q=0.8",
        },
        cache: "no-cache",
    });

    if (!response.ok) {
        throw new Error(
            `Failed to load ${url} (${response.status} ${response.statusText})`
        );
    }

    return response.text();
}

async function loadMarkdown(url, target) {
    const element = document.getElementById(target);

    if (!element) {
        throw new Error(`Target element not found: #${target}`);
    }

    const controller = new AbortController();

    const timeout = setTimeout(
        () => controller.abort(),
        REQUEST_TIMEOUT
    );

    try {
        element.setAttribute("aria-busy", "true");

        const markdown = await fetchMarkdown(
            url,
            controller.signal
        );

        if (typeof marked === "undefined") {
            throw new Error("Marked.js is not loaded.");
        }

        element.innerHTML = marked.parse(markdown);

        element.setAttribute("data-source", url);
        element.setAttribute("data-loaded", "true");
    } catch (error) {
        const message =
            error.name === "AbortError"
                ? "Request timed out."
                : error instanceof Error
                    ? error.message
                    : String(error);

        element.replaceChildren(
            Object.assign(document.createElement("pre"), {
                textContent: `Unable to load Markdown.\n\n${message}`,
            })
        );

        element.setAttribute("data-error", "true");
    } finally {
        clearTimeout(timeout);
        element.setAttribute("aria-busy", "false");
    }
}

async function loadAllMarkdown(sources) {
    const results = await Promise.allSettled(
        Object.entries(sources).map(
            ([target, url]) => loadMarkdown(url, target)
        )
    );

    return results;
}

loadAllMarkdown(MARKDOWN_SOURCES);
