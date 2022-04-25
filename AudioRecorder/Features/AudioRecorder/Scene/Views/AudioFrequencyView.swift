import UIKit

final class AudioFrequencyView: UIView {
    private var frequences: [AudioFrequencyUnitView] = {
        var list: [AudioFrequencyUnitView] = []
        for _ in 0...120 {
            list.append(AudioFrequencyUnitView())
        }

        return list
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: frequences)
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

    func updateFrequency(sizes: Queue<Float>) {
        sizes.enumerated().forEach { (index, size) in
            guard let size = size as? Float else { return }

            frequences[index].updateSize(size: CGFloat(size))
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
