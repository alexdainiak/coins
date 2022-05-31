//
//  Array+StabProtocol.swift
//  Coins.phTests
//
//  Created by Дайняк Александр Николаевич on 01.05.2021.
//

extension Array where Element: StubProtocol {

    static func stub(withCount count: Int) -> Array {
        return (1...count).map {
            .stub(withId: $0)
        }
    }
}
