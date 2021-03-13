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
}
