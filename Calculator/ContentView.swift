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
    case multiply = "*"
    case equal = "="
    case clearAll = "AC"
    case deleteOne = "<-"
    case dot = "."
    case percent = "%"
    
    
    
    
    
    var color: Color {
        switch self {
        case .divide, .multiply, .substruct, .sum, .deleteOne, .percent:
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
    private let valueController = ValueController()
    
    let buttons: [[ButtonText]] = [
        [.clearAll, .deleteOne, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substruct],
        [.one, .two, .three, .sum],
        [.zero, .dot, .equal]
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
            return ((UIScreen.main.bounds.width) / 4) * 2 - 12 * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeigth() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    
    
    func tap (button: ButtonText) -> Void {
        switch button {
        case .sum, .substruct, .multiply, .divide:
            self.value = valueController.addOperation(value: self.value, symbol: button.rawValue)
            break
        case .clearAll:
            self.value = valueController.clearAll();
            break
        case .deleteOne:
            self.value = valueController.removeLast(value: self.value)
        case .equal:
            let calculate: Calculate = Calculate()
            self.value = calculate.calc(expression: self.value)
            break
        case .dot:
            let regex = #/(^|[+\-*\/])\d+$/#
            if let match = self.value.firstMatch(of: regex) {
                self.value = valueController.printSymbol(incoming: button.rawValue, value: self.value)
            }
            break
        default:
            self.value = valueController.printSymbol(incoming: button.rawValue, value: self.value)
        }
    }
    
    
}

#Preview {
    ContentView()
}
