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
        NavigationView {
            VStack {
                ScheduleView()
                StartButton() + StopButton()
                Spacer()
            }
        }
        .onAppear {
            self.start = Sentinel.shared.start ?? Date()
            self.end = Sentinel.shared.end ?? Date()
        }
    }
}

extension SchedulerView {
    
    fileprivate func StopButton() -> some View {
        return Button {
            sentinel.reset()
            sentinel.stopMonitoring()
        } label: {
            Label {
                Text(" Stop".uppercased())
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: "stop.circle.fill")
                    .foregroundColor(.red)
            }
            .padding()
            .background(.orange)
            .cornerRadius(.m)
            
        }
        .padding()
    }
    
    fileprivate func StartButton() -> some View {
        return Button {
            sentinel.reset()
            sentinel.stopMonitoring()
            sentinel.blockAll()
        } label: {
            Label {
                Text("Start".uppercased())
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: "play.circle.fill")
            }
            .padding()
            .background(.cyan)
            .cornerRadius(.m)
        }
        .padding()
    }
    
    fileprivate func ScheduleView() -> some View {
        return Section {
            DatePicker("Start", selection: $start, displayedComponents: DatePickerComponents.hourAndMinute)
                .padding()
            
            
            DatePicker("End", selection: $end, displayedComponents: DatePickerComponents.hourAndMinute)
                .padding()
        } header: {
            Text("Schedule".uppercased())
                .font(.title2)
                .bold()
        }
        .padding()
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
