//
//  SchedulerView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-29.
//

import SwiftUI

struct SchedulerView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sentinel: Sentinel
    @State private var showAddWebsiteView = false
    
    @State private var start: Date = Date() {
        didSet {
            sentinel.start = start
        }
    }
    @State private var end: Date = Date() {
        didSet {
            sentinel.end = end
        }
    }
    
    var body: some View {
        VStack {
            DatePicker("Start", selection: $start, displayedComponents: DatePickerComponents.hourAndMinute)
                .padding()
            
            
            DatePicker("End", selection: $end, displayedComponents: DatePickerComponents.hourAndMinute)
                .padding()
            
            Button {
                sentinel.reset()
                sentinel.stopMonitoring()
                sentinel.blockAll()
            } label: {
                Text("Save")
            }
            .padding()
            
            // MARK: DEBUG
            Button {
                sentinel.reset()
                sentinel.stopMonitoring()
            } label: {
                Text("Unblock (DEBUG)")
                    .foregroundColor(.brown)
            }
            .padding()
        }
    }
}

struct SchedulerView_Previews: PreviewProvider {
    static var previews: some View {
        let sentinel = Sentinel.shared
        SchedulerView()
            .environmentObject(sentinel)
            .environment(\.managedObjectContext, PersistenceController.preview.context)
    }
}
