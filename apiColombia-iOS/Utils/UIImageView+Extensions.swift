//
//  UIImageView+Extensions.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import UIKit

private var imageSpinnerKey: UInt8 = 0

extension UIImageView {
    
    func loadImage(from urlString: String) {
        self.image = nil
        self.backgroundColor = .systemGray6
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        let spinner: UIActivityIndicatorView
        if let existing = objc_getAssociatedObject(self, &imageSpinnerKey) as? UIActivityIndicatorView {
            spinner = existing
        } else {
            spinner = UIActivityIndicatorView(style: .medium)
            spinner.hidesWhenStopped = true
            spinner.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(spinner)
            NSLayoutConstraint.activate([
                spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
            objc_setAssociatedObject(self, &imageSpinnerKey, spinner, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        spinner.startAnimating()
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString) else {
            print("❌ Error: URL inválida (encoding falló): \(urlString)")
            spinner.stopAnimating()
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let loadedImage = UIImage(data: data) else {
                    print("⚠️ Error: No se pudo crear imagen desde data para: \(url)")
                    await MainActor.run { spinner.stopAnimating() }
                    return
                }
                
                await MainActor.run {
                    self.image = loadedImage
                    spinner.stopAnimating()
                }
            } catch {
                print("❌ Error descargando imagen: \(error)")
                await MainActor.run { spinner.stopAnimating() }
            }
        }
    }
}
