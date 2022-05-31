//
//  Single+HandleError.swift
//  Network
//
//  Created by Дайняк Александр Николаевич on 30.04.2021.
//

import Moya
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait {
    func handleError<T: ErrorTranslator>(using translator: T) -> Single<Element> {
        return catchError { [translator] error -> PrimitiveSequence<Trait, Element> in
            throw translator.translate(from: error)
        }
    }
}
