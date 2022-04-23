import UIKit

final class AudioRecorderPermissionViewController: UIViewController {
    private lazy var permissionButton: UIButton = {
        let button = SimpleButton(title: "Tap to give permission please") { [weak self] in
            self?.checkPermission()
        }

        return button
    }()

    private let audioPermission: AudioPermission

    init(audioPermission: AudioPermission) {
        self.audioPermission = audioPermission
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        checkPermission()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "PrimaryBackground")
    }

    private func setupPermissionButton() {
        view.addSubview(permissionButton)
        let constraints = [
            permissionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            permissionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc private func permissionButtonTapped() {
        checkPermission()
    }

    private func checkPermission() {
        audioPermission.ask { [weak self] in
            if $0 {
                self?.showAudioRecorder()
            }
        }
    }

    private func showAudioRecorder() {
        let viewController = AudioRecorderConfigurator.configure()
        present(viewController, animated: true)
    }
}
