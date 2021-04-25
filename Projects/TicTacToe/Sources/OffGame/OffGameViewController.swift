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
    private var score: Score?


    // MARK: UI

    private let player1Label = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.backgroundColor = .clear
        $0.textColor = .blue
        $0.textAlignment = .center
    }
    private let vsLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.backgroundColor = .clear
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.text = "vs"
    }
    private let player2Label = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.backgroundColor = .clear
        $0.textColor = .red
        $0.textAlignment = .center
    }
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
        self.bindStart()
        self.configurePlayer()
    }

    private func bindStart() {
        self.startButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.listener?.startGame()
            })
            .disposed(by: self.disposeBag)
    }

    private func configurePlayer() {
        let player1Score = self.score?.player1Score ?? 0
        self.player1Label.text = "\(self.player1Name) \(player1Score)"

        let player2Score = self.score?.player2Score ?? 0
        self.player2Label.text = "\(self.player2Name) \(player2Score)"
    }


    // MARK: - OffGamePresentable

    func set(score: Score) {
        self.score = score
    }


    // MARK: - Layout

    override func configureLayout() {
        [
            self.player1Label,
            self.vsLabel,
            self.player2Label,
            self.startButton
        ]
        .forEach {
            self.view.addSubview($0)
        }

        self.player1Label.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(70)
            $0.leading.trailing.equalTo(self.view).inset(20)
            $0.height.equalTo(40)
        }
        self.vsLabel.snp.makeConstraints {
            $0.top.equalTo(self.player1Label.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.player1Label)
            $0.height.equalTo(20)
        }
        self.player2Label.snp.makeConstraints {
            $0.top.equalTo(self.vsLabel.snp.bottom).offset(10)
            $0.height.leading.trailing.equalTo(player1Label)
        }
        self.startButton.snp.makeConstraints {
            $0.center.equalTo(self.view)
            $0.leading.trailing.equalTo(self.view).inset(40)
            $0.height.equalTo(100)
        }
    }
}

extension PlayerType {
    var color: UIColor {
        switch self {
        case .player1:
            return UIColor.red
        case .player2:
            return UIColor.blue
        }
    }
}
