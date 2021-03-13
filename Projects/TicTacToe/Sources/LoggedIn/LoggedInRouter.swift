//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs

protocol LoggedInInteractable:
    Interactable,
    OffGameListener,
    TicTacToeListener {

    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter:
    Router<LoggedInInteractable>,
    LoggedInRouting {

    // MARK: - Properties

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private let ticTacToeBuilder: TicTacToeBuildable

    private var currentChild: ViewableRouting?


    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: LoggedInInteractable,
        viewController: LoggedInViewControllable,
        offGameBuilder: OffGameBuildable,
        ticTacToeBuilder: TicTacToeBuildable
    ) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        self.attachOffGame()
    }


    // MARK: - Methods

    private func attachOffGame() {
        let offGame = self.offGameBuilder.build(withListener: self.interactor)
        self.currentChild = offGame
        self.attachChild(offGame)
        self.viewController.present(viewController: offGame.viewControllable)
    }

    private func detachCurrentChild() {
        if let currentChild = self.currentChild {
            self.detachChild(currentChild)
            self.viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }


    // MARK: LoggedInRouting

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
        if let currentChild = self.currentChild {
            self.viewController.dismiss(viewController: currentChild.viewControllable)
        }
    }

    func routeToTicTacToe() {
        self.detachCurrentChild()

        let ticTacToe = ticTacToeBuilder.build(withListener: self.interactor)
        self.currentChild = ticTacToe
        self.attachChild(ticTacToe)
        self.viewController.present(viewController: ticTacToe.viewControllable)
    }

    func routeToOffGame() {
        self.detachCurrentChild()

        self.attachOffGame()
    }
}
