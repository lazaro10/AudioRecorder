import CoreGraphics
import UIKit

protocol AudioRecorderInteractorLogic {
    func requestRecording()
}

final class AudioRecorderInteractor: AudioRecorderInteractorLogic {
    private var frequencySizes = Queue<Float>()

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
        var size = amplitude * maximum / 0.1

        size = size > maximum ? maximum : size
        size = size < minimum ? minimum : size

        frequencySizes.enqueue(size)

        let maximumSupportedFrequency = Int(UIScreen.main.bounds.width / 4.0)

        if frequencySizes.count > maximumSupportedFrequency {
            frequencySizes.dequeue()
        }

        presenter.responseFrequencySizes(sizes: frequencySizes)
    }
}
