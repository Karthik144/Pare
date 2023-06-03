//
//  PromoSheetManager.swift
//  Pare
//
//  Created by Karthik  Ramu on 6/3/23.
//

import Foundation

final class PromoSheetManager: ObservableObject {

    enum Action {

        case na
        case present
        case dismiss

    }

    @Published private(set) var action: Action = .na

    func present(){
        guard !action.isPresented else { return }
        self.action = .present
    }

    func dismiss(){
        self.action = .dismiss
    }
}

extension PromoSheetManager.Action {

    var isPresented: Bool { self == .present }


}
