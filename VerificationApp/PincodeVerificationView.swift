//
//  PincodeVerificationView.swift
//
//  Created by Peter van de Put on 9/8/23.
//

import Foundation
import SwiftUI

struct PincodeVerificationView: View {
	@State private var otpText = ""
	@FocusState private var isKeyboardShowing: Bool
	let length = 6
	var body: some View {
		VStack  {
			HStack(spacing: 10){
				Spacer()
				ForEach(0..<length, id: \.self) { index in
					OTPTextBox(index)
				}
				Spacer()
			}
			.background(content: {
				TextField("", text: $otpText)
					.keyboardType(.numberPad)
					.textContentType(.oneTimeCode)
					.frame(width: 1, height: 1)
					.opacity(0.001)
					.blendMode(.screen)
					.focused($isKeyboardShowing)
					.onChange(of: otpText) { newValue in
						if newValue.count == length {
							let data = ["pincode" : otpText]
							NotificationCenter.default.post(name: Notification.Name.init("pincodeEntered"), object: nil, userInfo:data)
						}
					}
                   .onAppear {
						DispatchQueue.main.async {
							isKeyboardShowing = true
						}
					}
			})
			.contentShape(Rectangle())
			.onTapGesture {
				isKeyboardShowing = true
			}
			Spacer()
		}
	}
	
	@ViewBuilder
	func OTPTextBox(_ index: Int) -> some View {
		ZStack{
			if otpText.count > index {
				let startIndex = otpText.startIndex
				let charIndex = otpText.index(startIndex, offsetBy: index)
				let charToString = String(otpText[charIndex])
				Text("*")
			} else {
				Text(" ")
			}
		}
		.frame(width: 42, height: 42)
		.background {
			let status = (isKeyboardShowing && otpText.count == index)
			RoundedRectangle(cornerRadius: 6, style: .continuous)
				.stroke(status ? Color.green : Color.red)
				.animation(.easeInOut(duration: 0.2), value: status)
			
		}
	}
}
