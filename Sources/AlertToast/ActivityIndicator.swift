//
//  File.swift
//
//
//  Created by אילי זוברמן on 14/02/2021.
//

import SwiftUI

#if os(macOS)
@available(macOS 11, *)
struct ActivityIndicator: NSViewRepresentable {

    ///Unused on macOS: `NSProgressIndicator` always draws in the system color
    let color: Color?

    func makeNSView(context: NSViewRepresentableContext<ActivityIndicator>) -> NSProgressIndicator {
        let nsView = NSProgressIndicator()
        
        nsView.isIndeterminate = true
        nsView.style = .spinning
        nsView.startAnimation(context)
        
        return nsView
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: NSViewRepresentableContext<ActivityIndicator>) {
    }
}
#else
@available(iOS 14, *)
struct ActivityIndicator: UIViewRepresentable {

    ///Spinner color. `nil` keeps UIKit's default, an adaptive gray that is
    ///visible on both light and dark backgrounds.
    let color: Color?

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        
        let progressView = UIActivityIndicatorView(style: .large)
        progressView.startAnimating()
        
        return progressView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        //`color` is null-resettable: assigning nil restores the system default
        uiView.color = color.map { UIColor($0) }
    }
}
#endif
