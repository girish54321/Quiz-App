//
//  GlobalState.swift
//  Quiz App
//
//  Created by Girish Parate on 13/06/22.
//

import SwiftUI

class AppStateStorage: ObservableObject {
    @Published var isLoadingViewShowing : Bool = false
    
    func toogleLoading()  {
        withAnimation {
            isLoadingViewShowing.toggle()
        }
    }
}
