import AVFoundation

protocol AudioRecorderDelegate: AnyObject {
    func recorder(whenRecording amplitude: Float)
}

protocol AudioRecorderLogic  {
    var delegate: AudioRecorderDelegate? { get set }
    func changeRecordingState(state: AudioRecorder.State) throws
}

final class AudioRecorder: AudioRecorderLogic {
    enum State {
        case recording, paused, resume, stopped
    }

    private var engine: AVAudioEngine!
    private var mixerNode: AVAudioMixerNode!
    private let bufferConverter: AudioBufferConverterLogic
    weak var delegate: AudioRecorderDelegate?

    init(bufferConverter: AudioBufferConverterLogic) {
        self.bufferConverter = bufferConverter

        setupSession()
        setupEngine()
    }

    func changeRecordingState(state: State) throws {
        switch state {
        case .recording:
            try startRecording()
        case .paused:
            pauseRecording()
        case .resume:
            try resumeRecording()
        case .stopped:
            stopRecording()
        }
    }

    private func setupSession() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.record)
        try? session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func setupEngine() {
        engine = AVAudioEngine()
        mixerNode = AVAudioMixerNode()

        mixerNode.renderingAlgorithm = .HRTF
        mixerNode.volume = 0
        engine.attach(mixerNode)
        makeConnections()
        engine.prepare()
    }

    private func makeConnections() {
        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        engine.connect(inputNode, to: mixerNode, format: inputFormat)

        let mainMixerNode = engine.mainMixerNode
        let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
        engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)
    }

    private func startRecording() throws {
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)

        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format) { [weak self] buffer, time in
            self?.delegate?.recorder(whenRecording: self?.bufferConverter.toAmplitude(from: buffer) ?? 0.0)
        }

        try engine.start()
    }

    private func resumeRecording() throws {
        try engine.start()
    }

    private func pauseRecording() {
        engine.pause()
    }

    private func stopRecording() {
        mixerNode.removeTap(onBus: 0)
        engine.stop()
    }
}
