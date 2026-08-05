private CancellationTokenSource _cts;

private async void OnG4CommandTriggered(string voiceCommand)
{
    // Cancel any ongoing generation if the user speaks again
    _cts?.Cancel();
    _cts = new CancellationTokenSource();

    ResponseTextBlock.Text = ""; // Clear previous response

    await _g4Service.StreamG4ResponseAsync(
        prompt: voiceCommand, 
        onTokenReceived: (token) => 
        {
            ResponseTextBlock.Text += token; 
            // Optional: Auto-scroll your ScrollViewer here
        }, 
        cancellationToken: _cts.Token
    );
}
