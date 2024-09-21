//
//  FavoriteView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Jackie Lu on 2024/9/20.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.userFavoriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove from favorites") {
                            viewModel.removeUserFavoriteProduct(favoriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favorite")
        .onFirstAppear {
            viewModel.addListenerForFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
