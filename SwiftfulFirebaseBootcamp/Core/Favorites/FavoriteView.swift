//
//  FavoriteView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Jackie Lu on 2024/9/20.
//

import SwiftUI

@MainActor
final class FavoriteViewModel: ObservableObject {
    
    @Published private(set) var userFavoriteProducts: [UserFavoriteProduct] = []
    
    
    func getFavorites() {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            self.userFavoriteProducts = try await UserManager.shared.getAllUserFavoriteProducts(userId: authDataResult.uid)
        }
    }
    
    func removeUserFavoriteProduct(favoriteProductId: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
            try? await UserManager.shared.removeUserFavoriteProduct(userId: authDataResult.uid, favoriteProductId: favoriteProductId)
            getFavorites()
        }
    }
}

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
        .onAppear {
            viewModel.getFavorites()
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteView()
    }
}
