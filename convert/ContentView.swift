//
//  ContentView.swift
//  convert
//
//  Created by Kristoffer Eriksson on 2021-01-26.
//

import SwiftUI

struct ContentView: View {
    //conversion variables
    @State private var inputUnit = ""
    @State private var unit = ""
    
    let measures = ["cm", "inch"]
    
    //input value
    var value: Measurement<UnitLength> {
        let input = Double(inputUnit) ?? 0
        
        switch unit {
        case "cm":
            let returnValue = Measurement(value: input, unit: UnitLength.centimeters)
            
            return returnValue
            
        case "inch":
            let returnValue = Measurement(value: input, unit: UnitLength.inches)
            
            return returnValue
        default:
            return Measurement(value: 0, unit: UnitLength.centimeters)
        }

    }
    //converted value to present
    var convertedValue: Measurement<UnitLength> {
        let convert = value
        
        switch unit {
        case "cm":
            return convert.converted(to: UnitLength.inches)
        default:
            
            return convert.converted(to: UnitLength.centimeters)
        }
    }
    
    var reversedUnit: String {
        switch unit {
        case "cm":
            return "inch"
        case "inch":
            return "cm"
        default:
            return " "
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("input: ")){
                    TextField("input \(unit)", text: $inputUnit)
                        .keyboardType(.decimalPad)
                    
                    Picker("Unit", selection: $unit) {
                        ForEach(0 ..< measures.count){
                            Text("\(self.measures[$0])").tag(self.measures[$0])
                            //.tag is needed or else it doesnt register
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("converted number:")){
                    Text("\(convertedValue.value, specifier: "%.2F") \(reversedUnit)")
                }
            }
            .navigationTitle("Length conversion")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
