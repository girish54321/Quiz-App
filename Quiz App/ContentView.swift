//
//  ContentView.swift
//  Quiz App
//
//  Created by Girish Parate on 10/06/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @EnvironmentObject var appStateStorage: AppStateStorage
    
    var body: some View {
        VStack {
            WelcomeScreen()
        }
        .overlay {
            if appStateStorage.isLoadingViewShowing == true {
                LoadingIndicator()
            } else {
                EmptyView()
            }
//            LoadingIndicator()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
