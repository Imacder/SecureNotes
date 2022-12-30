//
//  ContentView.swift
//  SecureNotes
//
//  Created by Albert Kong on 2022/12/29.
//

import SwiftUI


struct SecureFilesView: View {
    @AppStorage("firstStartUp") var firstStartUp: Bool = true
    @AppStorage("securefiles") var securefiles: [String] = []
    @AppStorage("securefilesdata") var securefilesdata: [String: String] = [:]
    @Binding var fileselection: String?
    
    init(fileselection: Binding<String?>){
        _fileselection = fileselection
        if firstStartUp{
            firstStartUp = false
            securefiles = []
            securefilesdata = [:]
        }
    }
    
    var body: some View {
        ScrollView {
            List(securefiles, id: \.secure_id, selection: $fileselection){ filename in
                Text(filename)
            }
        }
    }
}


struct NormalFilesView: View {
    @AppStorage("firstStartUp") var firstStartUp: Bool = true
    @AppStorage("normalfiles") var normalfiles: [String] = []
    @AppStorage("securefilesdata") var normalfilesdata: [String: String] = [:]
    @Binding var fileselection: String?
    
    init(fileselection: Binding<String?>){
        _fileselection = fileselection
        if firstStartUp{
            firstStartUp = false
            normalfiles = []
            normalfilesdata = [:]
        }
    }
    
    var body: some View {
        ScrollView {
            List(normalfiles, id: \.normal_id, selection: $fileselection){ filename in
                Text(filename)
            }
        }
    }
}


struct FileContentView: View {
    @Binding var fileselection: String?
    @AppStorage("securefiles") var securefiles: [String] = []
    @AppStorage("securefilesdata") var securefilesdata: [String: String] = [:]
    var body: some View {
        Text(fileselection ?? "")
    }
}


struct ContentView: View {
    @AppStorage("securefiles") var securefiles: [String] = []
    @AppStorage("securefilesdata") var securefilesdata: [String: String] = [:]
    @State var fileselection: String?
    
    init(){
        fileselection = ""
    }
    
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
                    Label("Secure Notes", systemImage: "shield.righthalf.filled")
                        .padding(.leading)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            Section {
                NormalFilesView(fileselection: $fileselection)
            } header: {
                HStack{
                    Label("Normal Notes", systemImage: "note.text")
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
