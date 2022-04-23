protocol AudioRecorderInteractorLogic {
    func requestRecording()
}

final class AudioRecorderInteractor: AudioRecorderInteractorLogic {
    private let presenter: AudioRecorderPresentationLogic
    private var audioRecorder: AudioRecorderLogic
    
    init(presenter: AudioRecorderPresentationLogic, audioRecorder: AudioRecorderLogic) {
        self.presenter = presenter
        self.audioRecorder = audioRecorder
        self.audioRecorder.delegate = self
    }

    func requestRecording() {
        do {
            try audioRecorder.changeRecordingState(state: .recording)
        } catch {
            // response error
        }
    }
}

extension AudioRecorderInteractor: AudioRecorderDelegate {
    func recorder(whenRecording amplitude: Float) {
        let minimum: Float = 1.0
        let maximum: Float = 50.0
        let size = amplitude * maximum / 0.1

        guard size > minimum else {
            presenter.responseFrequencySize(size: minimum)
            return
        }

        guard size < maximum else {
            presenter.responseFrequencySize(size: maximum)
            return
        }

        presenter.responseFrequencySize(size: size)
    }
}
