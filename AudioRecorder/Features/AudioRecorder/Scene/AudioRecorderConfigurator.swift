enum AudioRecorderConfigurator {
    static func configure() -> AudioRecorderViewController {
        let presenter = AudioRecorderPresenter()
        let audioBufferConter = AudioBufferConverter()
        let audioRecorder = AudioRecorder(bufferConverter: audioBufferConter)
        let interactor = AudioRecorderInteractor(presenter: presenter, audioRecorder: audioRecorder)
        let viewController = AudioRecorderViewController(interactor: interactor)
        presenter.display = viewController

        return viewController
    }
}
