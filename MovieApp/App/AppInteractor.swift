//
//  AppInteractor.swift
//  MovieApp
//
//  Created by Izuchukwu Dennis on 03.09.2022.
//

import UIKit

protocol AppInteractorProtocol {
  func setInitialScreen()
}

final class AppInteractor: AppInteractorProtocol {
  private var coordinator: AppCoordinatorProtocol?
  private weak var windowScene: UIWindowScene!

  init(windowScene: UIWindowScene) {
    self.windowScene = windowScene
    self.coordinator = AppCoordinator()
    setInitialScreen()
  }

  func setInitialScreen() {
    // check if user is registered ? register_screen_Init : homeScreen
    coordinator?.createHomePages(scene: windowScene)
  }
}
