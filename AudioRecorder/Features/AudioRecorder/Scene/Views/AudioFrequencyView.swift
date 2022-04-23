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

    func addNewFrequency(size: Float) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.stackView.addArrangedSubview(AudioFrequencyUnitView(size: CGFloat(size)))
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.stackView.arrangedSubviews.count > 120 {
                let first = self.stackView.arrangedSubviews[0]

                self.stackView.removeArrangedSubview(first)
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
