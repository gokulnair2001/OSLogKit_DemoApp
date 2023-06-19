//
//  ContentView.swift
//  Test_OSKit
//
//  Created by Gokul Nair on 16/06/23.
//

import SwiftUI
import OSLogKit

struct ContentView: View {
    
    let logger: OSLogKit = OSLogKit(subSystem: "com.gokulnair.Test-OSKit", category: "ContentView")
    
    @State var logArray:[String] = []
    @State var logMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    // Some view
                }.captureLogOnTap(logger, "OSLogKit test log") {
                    // additional on tap action (Optional)
                }
                
                VStack {
                    TextField("Enter log message", text: $logMessage)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        
                        if !logMessage.isEmpty {
                            
                            logger.capture(message: logMessage)
                            logMessage = ""
                        }
                        
                    }label: {
                        HStack(spacing: 10) {
                            Spacer()
                            
                            Text("Capture log")
                                .font(.system(size: 16, weight: .medium, design: .monospaced))
                            
                            Spacer()
                            
                        }.frame(height: 40)
                            .padding(2)
                            .foregroundColor(.white)
                            .background(.orange)
                            .cornerRadius(6)
                    }
                }.padding(10)
                
                if logArray.isEmpty {
                    Spacer()
                    VStack(spacing: 8) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Text("No logs exist")
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                    }
                    Spacer()
                } else {
                    List(logArray, id: \.self) { log in
                        Text(log)
                    }
                }
                
            } .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        exportLogs()
                    }label: {
                        Text("Export")
                    }
                }
            }
            .navigationTitle(Text("OSLogKit"))
        }
    }
    
    private func exportLogs() {
        
        logger.exportLogs { result in
            
            switch result {
            case .success(let success):
                self.logArray = success
            case .failure(let failure):
                print(failure.errorDescription)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

