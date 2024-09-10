//
//  ContentView.swift
//  Calculator
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

enum ButtonText: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case sum = "+"
    case substruct = "-"
    case divide = "/"
    case multiply = "X"
    case equal = "="
    case clearAll = "AC"
    case deleteOne = "<-"
    case dot = "."
    
    
    
    
    
    var color: Color {
        switch self {
        case .divide, .multiply, .substruct, .sum, .deleteOne:
            return .init(red: 0.80, green: 0.86, blue: 1.0)
        case .clearAll, .equal:
            return .init(red: 0.6, green: 0.73, blue: 0.93)
        default:
            return .init(red: 0.96, green: 0.94, blue: 0.94)
        }
    }
    
}

struct ContentView: View {
    
    @State private var value = "0"
    
    let buttons: [[ButtonText]] = [
        [.clearAll, .divide, .multiply, .deleteOne],
        [.seven, .eight, .nine, .substruct],
        [.four, .five, .six, .sum],
        [.one, .two, .three, .equal],
        [.zero, .dot]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Text(value)
                    .bold()
                    .font(.system(size: 52))
                    .foregroundColor(.black)
            }
            .padding()
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { item in
                        Button(
                            action: {
                                self.tap(button: item)
                            },
                            label: {
                                Text (item.rawValue)
                                    .frame(
                                        width: buttonWidth(button: item),
                                        height: buttonHeigth()
                                    )
                                    .font(.system(size: 40))
                                    .background(item.color)
                                    .foregroundColor(.black)
                                    .cornerRadius(20)
                            })
                    }
                }
            }
        }
    }
    
    func buttonWidth (button: ButtonText) -> CGFloat {
        if (button == .zero) {
            return ((UIScreen.main.bounds.width) / 4) * 3 - 12 * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeigth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func tap (button: ButtonText) -> Void {
        switch button {
        case .sum, .substruct, .multiply, .divide:
            break
        case .clearAll:
            self.value = "0"
        case .deleteOne:
            self.value = String(self.value.prefix(self.value.count-1))
            if (self.value.count == 0) {
                self.value = "0"
            }
        default:
            let number = button.rawValue
            if (self.value == "0") {
                self.value = number
            }
            else {
                self.value = self.value + number
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
