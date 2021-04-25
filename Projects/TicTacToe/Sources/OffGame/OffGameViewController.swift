//
//  OffGameViewController.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol OffGamePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func startGame()
}

final class OffGameViewController:
    BaseViewController,
    OffGamePresentable,
    OffGameViewControllable {

    // MARK: - Properties

    weak var listener: OffGamePresentableListener?

    var uiviewController: UIViewController {
        return self
    }

    private let player1Name: String
    private let player2Name: String


    // MARK: UI

    private let startButton = UIButton().then {
        $0.setTitle("Start Game", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
    }


    // MARK: - Initializing

    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init()
        self.bind()
    }


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
    }


    // MARK: - Binding

    private func bind() {
        self.startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.listener?.startGame()
            })
            .disposed(by: self.disposeBag)
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
