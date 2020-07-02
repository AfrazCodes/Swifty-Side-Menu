//
//  ViewController.swift
//  MySideMenu
//
//  Created by Afraz Siddiqui on 7/2/20.
//  Copyright © 2020 ASN GROUP LLC. All rights reserved.
//

import SideMenu
import UIKit

class ViewController: UIViewController, MenuControllerDelegate {
    private var sideMenu: SideMenuNavigationController?

    private let settingsController = SettingsViewController()
    private let infoController = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: SideMenuItem.allCases)

        menu.delegate = self

        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true

        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        addChildControllers()
    }

    private func addChildControllers() {
        addChild(settingsController)
        addChild(infoController)

        view.addSubview(settingsController.view)
        view.addSubview(infoController.view)

        settingsController.view.frame = view.bounds
        infoController.view.frame = view.bounds

        settingsController.didMove(toParent: self)
        infoController.didMove(toParent: self)

        settingsController.view.isHidden = true
        infoController.view.isHidden = true
    }

    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }

    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)

        title = named.rawValue
        switch named {
        case .home:
            settingsController.view.isHidden = true
            infoController.view.isHidden = true

        case .info:
            settingsController.view.isHidden = true
            infoController.view.isHidden = false

        case .settings:
            settingsController.view.isHidden = false
            infoController.view.isHidden = true
        }

    }

}
