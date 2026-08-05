using System.Speech.Synthesis;
using System.Text;

namespace Aura.Intelligence
{
    public class StreamingTtsService
    {
        private readonly SpeechSynthesizer _synth;
        private readonly StringBuilder _sentenceBuffer;

        public StreamingTtsService()
        {
            // Initialize the Windows TTS engine
            _synth = new SpeechSynthesizer();
            _synth.SetOutputToDefaultAudioDevice();
            
            // Optional: Select a specific voice if installed
            // _synth.SelectVoice("Microsoft Zira Desktop"); 
            
            _sentenceBuffer = new StringBuilder();
        }

        /// <summary>
        /// Call this method inside your G4 stream's onTokenReceived callback.
        /// </summary>
        public void ProcessIncomingToken(string token)
        {
            _sentenceBuffer.Append(token);
            string currentText = _sentenceBuffer.ToString();

            // Look for natural sentence boundaries
            int splitIndex = currentText.LastIndexOfAny(new[] { '.', '?', '!' });

            // If we found punctuation, we have a complete thought to speak
            if (splitIndex >= 0)
            {
                // Extract the completed sentence, including the punctuation mark
                string sentenceToSpeak = currentText.Substring(0, splitIndex + 1);
                
                // Queue the sentence for audio playback asynchronously
                _synth.SpeakAsync(sentenceToSpeak.Trim());

                // Keep any remaining characters (the start of the next sentence) in the buffer
                string remainder = currentText.Substring(splitIndex + 1);
                _sentenceBuffer.Clear();
                _sentenceBuffer.Append(remainder);
            }
        }

        /// <summary>
        /// Call this when the G4 stream completely finishes, to ensure 
        /// any final words without punctuation are spoken.
        /// </summary>
        public void FlushRemaining()
        {
            string remainingText = _sentenceBuffer.ToString().Trim();
            if (!string.IsNullOrEmpty(remainingText))
            {
                _synth.SpeakAsync(remainingText);
            }
            _sentenceBuffer.Clear();
        }

        /// <summary>
        /// Instantly stops the audio queue if the user interrupts.
        /// </summary>
        public void StopAudio()
        {
            _synth.SpeakAsyncCancelAll();
            _sentenceBuffer.Clear();
        }
    }
}
