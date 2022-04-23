import UIKit

final class AudioFrequencyUnitView: UIView {
    private let dashView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "OwlPink")

        return view
    }()

    init(size: CGFloat) {
        super.init(frame: .zero)

        setupDashView(size: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDashView(size: CGFloat) {
        addSubview(dashView)
        
        let constraints = [
            dashView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dashView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            dashView.widthAnchor.constraint(equalToConstant: 1),
            dashView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dashView.heightAnchor.constraint(equalToConstant: size)
        ]

        NSLayoutConstraint.activate(constraints)
    }

}
