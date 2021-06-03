//
//  Observable.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 02.06.2021.
//

import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }

    init(value: T) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        self.listener = listener
    }
}
