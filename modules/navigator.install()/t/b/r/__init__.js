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
