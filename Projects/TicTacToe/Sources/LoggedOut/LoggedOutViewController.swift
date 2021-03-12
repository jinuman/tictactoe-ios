//
//  LoggedOutViewController.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController:
    BaseViewController,
    LoggedOutPresentable,
    LoggedOutViewControllable {

    // MARK: - Properties

    weak var listener: LoggedOutPresentableListener?


    // MARK: - UI

    private let player1Field = UITextField().then {
        $0.borderStyle = .line
        $0.placeholder = "Player 1 name"
    }
    private let player2Field = UITextField().then {
        $0.borderStyle = .line
        $0.placeholder = "Player 2 name"
    }
    private lazy var loginButton = UIButton().then {
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor.black
        $0.addTarget(self, action: #selector(self.didTapLoginButton), for: .touchUpInside)
    }


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }


    // MARK: - Layout

    override func configureLayout() {
        self.view.addSubview(self.player1Field)
        self.view.addSubview(self.player2Field)
        self.view.addSubview(self.loginButton)

        self.player1Field.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(100)
            $0.leading.trailing.equalTo(self.view).inset(40)
            $0.height.equalTo(40)
        }
        self.player2Field.snp.makeConstraints {
            $0.top.equalTo(self.player1Field.snp.bottom).offset(20)
            $0.left.right.height.equalTo(self.player1Field)
        }
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.player2Field.snp.bottom).offset(20)
            $0.left.right.height.equalTo(self.player1Field)
        }
    }

    @objc private func didTapLoginButton() {
        self.listener?.login(
            withPlayer1Name: self.player1Field.text,
            player2Name: self.player2Field.text
        )
    }
}
