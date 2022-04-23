import AVFoundation

protocol AudioPermission {
    func ask(completionHandler: @escaping (Bool) -> Void)
}

final class AudioPermissionLogic: AudioPermission {
    let audioSession: AVAudioSession

    init(audioSession: AVAudioSession) {
        self.audioSession = audioSession
    }

    func ask(completionHandler: @escaping (Bool) -> Void) {
        do {
            try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    completionHandler(allowed)
                }
            }
        } catch {
            completionHandler(false)
        }
    }
}
