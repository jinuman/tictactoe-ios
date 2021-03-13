//
//  OffGameViewController.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs
import RxSwift
import UIKit

protocol OffGamePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class OffGameViewController:
    BaseViewController,
    OffGamePresentable,
    OffGameViewControllable {

    weak var listener: OffGamePresentableListener?

    var uiviewController: UIViewController {
        return self
    }


    // MARK: UI

    private let startButton = UIButton().then {
        $0.setTitle("Start Game", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    }


    // MARK: - Initializing

    override init() {
        super.init()
    }


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
    }


    // MARK: - Layout

    override func configureLayout() {
        self.view.addSubview(self.startButton)

        self.startButton.snp.makeConstraints {
            $0.center.equalTo(self.view)
            $0.leading.trailing.equalTo(self.view).inset(40)
            $0.height.equalTo(100)
        }
    }
}
