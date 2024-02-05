//
//  PokemonRowViewModelTest.swift
//  PokemonAPITests
//
//  Created by Joan Narvaez on 4/02/24.
//

import XCTest
@testable import PokemonAPI

final class PokemonRowViewModelTest: XCTestCase {
    var sut: PokemonRowViewModel!
    var apiManager: APIManagerMock!

    override func setUp() {
        apiManager = APIManagerMock()
        sut = .init(pokemon: ResultsResponse(name: "Johanchu", url: ""),
                    apiManager: apiManager)
    }

    func testGetPokemonDetail() async throws {
        let expectedValue = PokemonDetail(types: [PokemonType(type: TypeResponse(name: "Fumancho"))], abilities: [], moves: [])
        apiManager.executeResult = expectedValue
        await sut.getPokemon()
        XCTAssertEqual(expectedValue, sut.pokemonDetail)
    }

}

extension PokemonRowViewModelTest {
    class APIManagerMock: APIManagerProtocol {

        var executeResult: PokemonDetail!

        func request<T>(url: String, httpMethod: String, request: Encodable?) async throws -> T where T : Decodable {
            return executeResult as! T
        }

    }
}
