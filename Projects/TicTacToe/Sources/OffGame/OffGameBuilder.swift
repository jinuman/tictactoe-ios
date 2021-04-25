//
//  OffGameBuilder.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs

protocol OffGameDependency: Dependency {
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
}

final class OffGameComponent: Component<OffGameDependency> {
    fileprivate var player1Name: String {
        return super.dependency.player1Name
    }

    fileprivate var player2Name: String {
        return super.dependency.player2Name
    }

    fileprivate var scoreStream: ScoreStream {
        return super.dependency.scoreStream
    }
}

// MARK: - Builder

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: Builder<OffGameDependency>, OffGameBuildable {
    override init(dependency: OffGameDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        let component = OffGameComponent(dependency: dependency)
        let viewController = OffGameViewController(
            player1Name: component.player1Name,
            player2Name: component.player2Name
        )
        let interactor = OffGameInteractor(
            presenter: viewController,
            scoreStream: component.scoreStream
        )
        interactor.listener = listener
        return OffGameRouter(interactor: interactor, viewController: viewController)
    }
}
