import UIKit

final class AudioFrequencyView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    init() {
        super.init(frame: .zero)

        setupStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fillFrequencies(sizes: Queue<Float>) {
        sizes.enumerated().forEach { (index, size) in
            guard let size = size as? Float else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.stackView.arrangedSubviews.count < sizes.count {
                    self.stackView.addArrangedSubview(AudioFrequencyUnitView(size: size))
                } else {
                    let audioFrequencyUnitView = self.stackView.arrangedSubviews[index] as? AudioFrequencyUnitView
                    audioFrequencyUnitView?.updateSize(size: size)
                }
            }
        }
    }

    private func setupStackView() {
        addSubview(stackView)

        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
