//
//  ViewControllerTests.swift
//  TraktAPITests
//
//  Created by Edgar Cardoso on 08/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import XCTest
import KIF
import Nimble
@testable import TraktAPI

class ViewControllerTests: XCTestCase {
    
    var navController: UINavigationController?
    var controller: ViewController?
    var networkMock = NetworkRequestMock()
    lazy var manager = MovieManager(network: networkMock)
    
    override func setUp() {
        super.setUp()
        let window = UIApplication.shared.keyWindow?.rootViewController
        navController = window as? UINavigationController
        controller = navController?.viewControllers[0] as? ViewController
        controller?.manager = manager
        controller?.loadMovies()
    }
    
    override func tearDown() {
        networkMock.success = true
        super.tearDown()
    }
    
    func testLoadMovies() {
        let count = controller?.collectionView.numberOfItems(inSection: 0)
        expect(count) == 10
    }
    
    func testSearchMovie() {
        self.tester().enterText("Tron\n", intoViewWithAccessibilityIdentifier: "SEARCH_BAR")
        let count = controller?.collectionView.numberOfItems(inSection: 0)
        expect(count) == 11
    }
    
    func testNetworkFailure() {
        self.tester().acknowledgeSystemAlert()
        networkMock.success = false
        self.tester().pullToRefreshView(withAccessibilityIdentifier: "COLLECTION_VIEW")
        self.tester().waitForView(withAccessibilityLabel: "Erro")
        self.tester().tapView(withAccessibilityLabel: "Ok")
    }
    
    func testPressCollectionView() {
        self.tester().tapItem(at: IndexPath(item: 0, section: 0), inCollectionViewWithAccessibilityIdentifier: "COLLECTION_VIEW")
        self.tester().waitForView(withAccessibilityLabel: "Deadpool")
        navController?.popViewController(animated: true)
    }
}
