private async void OnG4CommandTriggered(string voiceCommand)
{
    _cts?.Cancel();
    _cts = new CancellationTokenSource();
    
    // Stop any currently playing TTS audio from a previous prompt
    _ttsService.StopAudio(); 
    ResponseTextBlock.Text = ""; 

    await _g4Service.StreamG4ResponseAsync(
        prompt: voiceCommand, 
        onTokenReceived: (token) => 
        {
            // Update the UI
            ResponseTextBlock.Text += token; 
            
            // Pipe the token into the audio buffer
            _ttsService.ProcessIncomingToken(token);
        }, 
        cancellationToken: _cts.Token
    );
    
    // Ensure the last few words are spoken when the stream ends
    _ttsService.FlushRemaining();
}
