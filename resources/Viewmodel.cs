using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using OpenAI.Responses; // Official V2 .NET SDK

namespace Aura.Intelligence
{
    public class G4IntegrationService
    {
        private readonly ResponsesClient _client;

        public G4IntegrationService(string apiKey)
        {
            // Initialize the client globally to reuse the connection pool
            _client = new ResponsesClient(apiKey);
        }

        /// <summary>
        /// Streams the G4 response directly into a target WPF UI element.
        /// </summary>
        public async Task StreamG4ResponseAsync(string prompt, Action<string> onTokenReceived, CancellationToken cancellationToken)
        {
            try
            {
                // 1. Open the stream to the G4 model
                var responses = _client.CreateResponseStreamingAsync(
                    model: "gpt-4o", 
                    userInputText: prompt,
                    cancellationToken: cancellationToken
                );

                // 2. Iterate asynchronously as chunks arrive
                await foreach (StreamingResponseUpdate response in responses)
                {
                    if (cancellationToken.IsCancellationRequested) break;

                    if (response is StreamingResponseOutputTextDeltaUpdate delta)
                    {
                        // 3. Dispatch the token back to the WPF UI thread
                        Application.Current.Dispatcher.InvokeAsync(() =>
                        {
                            onTokenReceived?.Invoke(delta.Delta);
                        });
                    }
                }
            }
            catch (TaskCanceledException)
            {
                // Handle graceful interruption (e.g., user issues a new voice command mid-generation)
            }
        }
    }
}
