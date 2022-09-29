//
//  KeyboardKey.swift
//  Nerdle
//
//  Created by Daniel Taylor English on 9/27/22.
//

import SwiftUI

struct KeyboardKey {
    let key: String
    var color: Color = .unused
    var isDisabled: Bool = false
    let action: () -> Void
}
