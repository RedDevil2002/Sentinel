//
//  DetailWebsiteView.swift
//  Sentinel
//
//  Created by Brian Seo on 2023-03-28.
//

import SwiftUI
import CoreData
import WebKit
import Combine

struct WebsiteView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: WebsiteViewModel
    @ObservedObject var pref = Preference.shared
    
    var body: some View {
        Form {
            PreviewSectionView()
            
            CategoryPicker()
            
            DomainTextField()
            
            ActionSectionView()
        }
    }
}

struct DetailWebsiteView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WebsiteViewModel()
        WebsiteView(viewModel: viewModel)
    }
}


// MARK: SubViews
extension WebsiteView {
    
    fileprivate func PreviewSectionView() -> some View {
        return
        Section {
            if pref.showPreviewOfURL {
                WebPreview(domain: viewModel.domain)
            }
        } header: {
            HStack {
                Toggle(isOn: $pref.showPreviewOfURL) {
                    Label {
                        Text("Preview")
                            .foregroundColor(.primary)
                    } icon: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.primary)
                            .fontWeight(.medium)
                    }
                }
                .toggleStyle(.button)
                
            }
        }
    }
    fileprivate func DomainTextField() -> some View {
        return Section {
            TextField("Domain", text: $viewModel.domain)
                .keyboardType(.URL)
                .textContentType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
    }
    
    fileprivate func CategoryPicker() -> some View {
        return Picker(selection: $viewModel.category) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.rawValue)
            }
        } label: {
            Text("Category")
        }
    }
    
    fileprivate func ActionSectionView() -> some View {
        return Section {
            Button {
                viewModel.saveWebsite()
                dismiss()
            } label: {
                Text("Save")
                    .foregroundColor(.blue)
            }
            
            Button {
                viewModel.destructButtonPressed()
                dismiss()
            } label: {
                viewModel.destructButton.label()
            }
        }
    }
}
