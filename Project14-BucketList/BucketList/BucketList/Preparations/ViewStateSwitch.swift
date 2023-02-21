//
//  ViewStateSwitch.swift
//  BucketList
//
//  Created by Lippmann, Erik on 08.02.23.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ViewStateSwitch: View {

    var loadingState = LoadingState.failed

    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

struct ViewStateSwitch_Previews: PreviewProvider {
    static var previews: some View {
        ViewStateSwitch()
    }
}
