//
//  Reactive+.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/11/22.
//

import RxSwift

/// Create Bindable property for LoaderView
extension Reactive where Base: LoaderView {
    var loading: Binder<Bool> {
        return Binder(self.base) { view, loading in
            if loading {
                view.startAnimation()
            } else {
                view.stopAnimation()
            }
        }
    }
}
