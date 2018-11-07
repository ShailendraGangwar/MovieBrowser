//
//  MBHomeViewControllerTests.swift
//  MovieBrowserTests
//
//  Created by Shailendra Gangwar on 07/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import UIKit
import XCTest
@testable import MovieBrowser

class MBHomeViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: MBHomeViewController!
    var tableView: UITableView?
    var featureView: MBFeaturedListView?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewControllerUnderTest = MBHomeViewController()
        tableView = UITableView()
        featureView = MBFeaturedListView()
        viewControllerUnderTest.movieListTableView = tableView
        viewControllerUnderTest.featuredListView = featureView
        _ = viewControllerUnderTest.view
        viewControllerUnderTest.setMoviesList(movies: [MBMovie(title: "Crazy, Stupid, Love.", year: "2011", imdbId: "tt1570728", type: "movie", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMTg2MjkwMTM0NF5BMl5BanBnXkFtZTcwMzc4NDg2NQ@@._V1_SX300.jpg")!, plot: "xyz" )])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.movieListTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.movieListTableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.movieListTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
}
