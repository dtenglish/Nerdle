//
//  KeyboardKey.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct KeyboardKey {
    let key: String
    let action: () -> Void
    var color: Color = .unused
}
