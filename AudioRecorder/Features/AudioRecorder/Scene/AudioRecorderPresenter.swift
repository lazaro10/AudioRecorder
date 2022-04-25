protocol AudioRecorderPresentationLogic {
    func responseFrequencySizes(sizes: Queue<Float>)
}

final class AudioRecorderPresenter: AudioRecorderPresentationLogic {
    weak var display: AudioRecorderDisplayLogic?

    func responseFrequencySizes(sizes: Queue<Float>) {
        display?.displayFrequencySizes(sizes: sizes)
    }
}
