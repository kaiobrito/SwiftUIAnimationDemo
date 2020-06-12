//
//  HostingController.swift
//  SwiftUIAnimationsDemo
//
//  Created by Kaio Brito on 12/06/20.
//  Copyright © 2020 Kaio Brito. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
