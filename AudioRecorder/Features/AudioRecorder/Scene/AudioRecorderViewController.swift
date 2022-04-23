import UIKit

protocol AudioRecorderDisplayLogic: AnyObject {
    func displayFrequencySize(size: Float)
}

final class AudioRecorderViewController: UIViewController {
    private lazy var recorderButton: UIButton = {
        let button = SimpleButton(title: "Record") { [weak self] in
            self?.interactor.requestRecording()
        }
        return button
    }()

    private let frequencyView: AudioFrequencyView = {
        let view = AudioFrequencyView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let interactor: AudioRecorderInteractorLogic

    init(interactor: AudioRecorderInteractorLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRecorderButton()
        setupFrequencyView()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "PrimaryBackground")
    }

    private func setupRecorderButton() {
        view.addSubview(recorderButton)
        let constraints = [
            recorderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recorderButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupFrequencyView() {
        view.addSubview(frequencyView)
        let constraints = [
            frequencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frequencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frequencyView.bottomAnchor.constraint(equalTo: recorderButton.topAnchor, constant: -30.0),
            frequencyView.heightAnchor.constraint(equalToConstant: 50.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

extension AudioRecorderViewController: AudioRecorderDisplayLogic {
    func displayFrequencySize(size: Float) {
        frequencyView.addNewFrequency(size: size)
    }
}
