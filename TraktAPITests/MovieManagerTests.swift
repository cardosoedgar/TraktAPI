//
//  NetworkRequestTests.swift
//  TraktAPITests
//
//  Created by Edgar Cardoso on 07/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import XCTest
import Nimble
@testable import TraktAPI

class MovieManagerTests: XCTestCase {
    var networkMock = NetworkRequestMock()
    lazy var manager = MovieManager(network: networkMock)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        manager = MovieManager(network: networkMock)
        networkMock.success = true
    }
    
    func testGetMovieOutOfBounds() {
        expect(self.manager.getMovie(at: 0)).to(beNil())
    }
    
    func testGetMovies() {
        var works = false
        manager.requestPopularMovies { success in
            works = success
        }
        expect(works).toEventually(be(true))
    }
    
    func testGetMoviesFail() {
        networkMock.success = false
        var works = true
        manager.requestPopularMovies { success in
            works = success
        }
        expect(works).toEventually(be(false))
    }
    
    func testGetMovieAtValidIndex() {
        var movie: Movie? = nil
        manager.requestPopularMovies { success in
            movie = self.manager.getMovie(at: 3)
        }
        expect(movie).toEventuallyNot(beNil())
    }
    
    func testGetAllMovies() {
        var movies: [Movie]? = nil
        manager.requestPopularMovies { success in
            movies = self.manager.getMovies()
        }
        expect(movies).toEventuallyNot(beNil())
        expect(movies?.count).toEventually(be(10))
    }
    
    func testSearchMovie() {
        var movies: [Movie]? = nil
        manager.requestMovie(with: "tron") { success in
            movies = self.manager.getMovies()
        }
        expect(movies).toEventuallyNot(beNil())
        expect(movies?.count).toEventually(be(11))
    }
    
    func testSearchMovieFail() {
        networkMock.success = false
        var works = true
        manager.requestMovie(with: "tron") { success in
            works = success
        }
        expect(works).toEventually(be(false))
    }
    
    func testGetImagesForMovie() {
        var works: [String]? = nil
        manager.requestImages(with: 155) { images in
            works = images
        }
        expect(works).toEventuallyNot(beNil())
    }
}
