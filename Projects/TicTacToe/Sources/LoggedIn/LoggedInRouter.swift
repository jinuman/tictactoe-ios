//
//  LoggedInRouter.swift
//  TicTacToe
//
//  Created by Jinwoo Kim on 2021/03/13.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener {
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

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // MARK: - Properties

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable

    private var currentChild: ViewableRouting?


    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: LoggedInInteractable,
        viewController: LoggedInViewControllable,
        offGameBuilder: OffGameBuildable
    ) {
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }

    override func didLoad() {
        super.didLoad()
        self.attachOffGame()
    }

    private func attachOffGame() {
        let offGame = self.offGameBuilder.build(withListener: self.interactor)
        self.currentChild = offGame
        self.attachChild(offGame)
        self.viewController.present(viewController: offGame.viewControllable)
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
}
