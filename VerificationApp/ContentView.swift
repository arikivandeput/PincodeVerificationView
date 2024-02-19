//
//  ContentView.swift
//  VerificationApp
//
//  Created by Peter Put on 19/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var pincode:String = ""
    var body: some View {
        VStack {
            Text("Enter the code you have received")
            PincodeVerificationView()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.init("pincodeEntered")))     { obj in
            self.pincode = obj.userInfo!["pincode"] as! String
            //do you validation if the code is correct
        }
        .padding()
    }
}
