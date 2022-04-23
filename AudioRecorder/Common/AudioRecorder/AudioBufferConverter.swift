import AVFoundation

protocol AudioBufferConverterLogic {
    func toAmplitude(from buffer: AVAudioPCMBuffer) -> Float
}

final class AudioBufferConverter: AudioBufferConverterLogic {
    func toAmplitude(from buffer: AVAudioPCMBuffer) -> Float {
        guard let channelDataStart = buffer.floatChannelData?[0] else {
            return 0.0
        }

        let channelData = Array(UnsafeBufferPointer(
            start: channelDataStart,
            count: Int(buffer.frameLength)
        ))

        let envelopeConstantAtk: Float = 0.16
        let envelopeConstantDec: Float = 0.003

        let outputEnvelope: [Float] = channelData.map { sample in
            let rectified = abs(sample)
            var envelopeState: Float = 0.0

            if envelopeState < rectified {
                envelopeState += envelopeConstantAtk * (rectified - envelopeState)
            } else {
                envelopeState += envelopeConstantDec * (rectified - envelopeState)
            }

            return envelopeState
        }

        if let maxVolume = outputEnvelope.max(), maxVolume > Float(0.015) {
            return maxVolume
        } else {
            return 0.0
        }
    }
}
