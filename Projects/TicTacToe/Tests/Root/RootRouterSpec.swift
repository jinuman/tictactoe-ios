//
//  RootRouterSpec.swift
//  TicTacToeTests
//
//  Created by Jinwoo Kim on 2021/04/16.
//

import Quick
import Nimble
@testable import TicTacToe

final class RootRouterSpec: QuickSpec {
    override func spec() {
        var rootRouter: RootRouter!
        var rootInteractor: RootInteractableMock!
        var loggedInBuilder: LoggedInBuildableMock!

        beforeEach {
            loggedInBuilder = LoggedInBuildableMock()
            rootInteractor = RootInteractableMock()
            rootRouter = RootRouter(
                interactor: rootInteractor,
                viewController: RootViewControllableMock(),
                loggedOutBuilder: LoggedOutBuildableMock(),
                loggedInBuilder: loggedInBuilder
            )
        }

        // This is an example of a router test case.
        // Test your router functions invokes the corresponding builder, attachesChild, presents VC, etc.
        context("routeToLoggedIn()") {
            it("LoggedInBuildable 프로토콜의 build() 메소드를 호출하고 return 된 Router 를 attach 합니다.") {
                // given
                let loggedInRouter = LoggedInRoutingMock(interactable: LoggedInInteractableMock())
                var assignedListener: LoggedInListener?
                loggedInBuilder.buildHandler = { (_ listener: LoggedInListener) -> LoggedInRouting in
                    assignedListener = listener
                    return loggedInRouter
                }
                expect(assignedListener).to(beNil())
                expect(loggedInBuilder.buildCallCount) == 0
                expect(loggedInRouter.loadCallCount) == 0

                // when
                rootRouter.routeToLoggedIn(withPlayer1Name: "1", player2Name: "2")

                // then
                expect(assignedListener) === rootInteractor
                expect(loggedInBuilder.buildCallCount) == 1
                expect(loggedInRouter.loadCallCount) == 1
            }
        }
    }
}
