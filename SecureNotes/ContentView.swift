//
//  ContentView.swift
//  SecureNotes
//
//  Created by Albert Kong on 2022/12/29.
//

import SwiftUI


struct SecureFilesView: View {
    @AppStorage("securefiles") var securefiles: [String] = []
    @AppStorage("firstStartUp") var firstStartUp: Bool = true
    @AppStorage("securefilesdata") var securefilesdata: [String: String] = [:]
    @Binding var fileselection: String
    
    init(fileselection: Binding<String>){
        _fileselection = fileselection
        if firstStartUp{
            firstStartUp = false
            securefiles = []
            securefilesdata = [:]
        }
    }
    
    var body: some View {
        List($securefiles, id: \.hash){ filename in
            
        }
    }
}


struct FileContentView: View {
    @Binding var fileselection: String
    var body: some View {
        Text("hello")
    }
}


struct ContentView: View {
    @AppStorage("securefiles") var securefiles: [String] = []
    @AppStorage("firstStartUp") var firstStartUp: Bool = true
    @AppStorage("securefilesdata") var securefilesdata: [String: String] = [:]
    @State var fileselection = "s0"
    
    var body: some View {
        NavigationSplitView {
            Text("SecureNotes")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .foregroundColor(.accentColor)
                .padding()
            #if os(macOS)
                .frame(width: 200)
            #endif
            Section {
                SecureFilesView(fileselection: $fileselection)
            } header: {
                HStack{
                    Label("Secure Files", systemImage: "shield.righthalf.filled")
                        .padding(.leading)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        } detail: {
            FileContentView(fileselection: $fileselection)
        }
        .navigationTitle(Text("SecureNotes"))
        .toolbar{
            #if os(iOS)
            ToolbarItem(placement: .bottomBar){
                Button{
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .bottomBar){
                Button{
                    
                } label: {
                    Image(systemName: "trash")
                }
            }
            #else
            Button{
                
            } label: {
                Image(systemName: "plus")
            }
            Button{
                
            } label: {
                Image(systemName: "trash")
            }
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
