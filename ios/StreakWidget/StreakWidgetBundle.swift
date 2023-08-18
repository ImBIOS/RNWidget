//
//  StreakWidgetBundle.swift
//  StreakWidget
//
//  Created by Imamuzzaki Abu Salam on 18/08/23.
//

import WidgetKit
import SwiftUI

@main
struct StreakWidgetBundle: WidgetBundle {
    var body: some Widget {
        StreakWidget()
        StreakWidgetLiveActivity()
    }
}
