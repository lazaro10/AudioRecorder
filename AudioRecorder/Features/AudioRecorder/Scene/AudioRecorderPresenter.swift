protocol AudioRecorderPresentationLogic {
    func responseFrequencySize(size: Float)
}

final class AudioRecorderPresenter: AudioRecorderPresentationLogic {
    weak var display: AudioRecorderDisplayLogic?

    func responseFrequencySize(size: Float) {
        display?.displayFrequencySize(size: size)
    }
}
