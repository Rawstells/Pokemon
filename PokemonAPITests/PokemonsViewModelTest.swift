//
//  PokemonsViewModelTest.swift
//  PokemonAPITests
//
//  Created by Joan Narvaez on 4/02/24.
//

@testable import PokemonAPI
import XCTest

final class PokemonsViewModelTest: XCTestCase {
    var sut: PokemonsViewModel!
    var apiManager: APIManagerMock!

    override func setUp() {
        apiManager = APIManagerMock()
        sut = .init(apiManager: apiManager)
    }

    func testGetPokemons() async throws {
        let expectedValue = PokemonResponse(results: [ResultsResponse(name: "Pokemon", url: "")])
        apiManager.executeResult = expectedValue
        await sut.getPokemons()
        XCTAssertEqual(expectedValue, sut.pokemonResponse)

    }
}

extension PokemonsViewModelTest {
    class APIManagerMock: APIManagerProtocol {

        var executeResult: PokemonResponse!

        func request<T>(url: String, httpMethod: String, request: Encodable?) async throws -> T where T : Decodable {
            return executeResult as! T
        }
    }
}
