//
//  ClientQuery.swift
//  ShopifyKit
//
//  Created by Amine on 2018-06-29.
//  Copyright © 2018 aminebadraoui. All rights reserved.
//

import Foundation
import MobileBuySDK

//  TODO: Make fragments in seperate files

public class ClientQuery {
    
    //  fetch all collections
    static func queryForAllCollections(limit: Int32 = 100) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .shop { $0
                .collections(first: limit) { $0
                    .edges { $0
                        .node { $0
                            .id()
                            .handle()
                            .title()
                            .description()
                            .image({ $0
                                .id()
                                .originalSrc()
                            })
                            .products(first: 1) { $0
                                .edges { $0
                                    .node { $0
                                        .images(first: 1) { $0
                                            .edges { $0
                                                .node { $0
                                                    .originalSrc()
                                                }
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //  fetch products in a specific collection
    static func queryForProducts( in collection: CollectionModel, sortKey: CollectionSortKey? = nil, limit: Int32 = 100, after cursor: String? = nil) -> Storefront.QueryRootQuery {
        var querySortKey: Storefront.ProductCollectionSortKeys = .collectionDefault
        
        if let sortKey = sortKey {
            switch sortKey {
            case .besteller: querySortKey = .bestSelling
            case .newest: querySortKey = .created
            }
        }
        
        return Storefront.buildQuery { $0
            .node(id: collection.model.id) { $0
                .onCollection { $0
                    .products(first: limit, sortKey: querySortKey) { $0
                        .edges{ $0
                            .node { $0
                                .id()
                                .handle()
                                .title()
                                .descriptionHtml()
                                .images(first: limit) { $0
                                    .edges({ $0
                                        .node { $0
                                            .id()
                                            .originalSrc()
                                        }
                                    })
                                }
                                .options { $0
                                    .id()
                                    .name()
                                    .values()
                                }
                                .variants(first: limit) { $0
                                    .edges({ $0
                                        .node { $0
                                            .id()
                                            .title()
                                            .image{
                                                $0.originalSrc()
                                            }
                                            .selectedOptions({ $0
                                                .name()
                                                
                                            })
                                            .sku()
                                            .price()
                                            .compareAtPrice()
                                            .availableForSale()
                                            .product {$0
                                                .handle()
                                                .title()
                                                .id()
                                                .description()
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //  fetch a specific collection by its handle
    static func queryForCollection(handle: String, limit: Int32 = 100) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .shop { $0
                .collectionByHandle(handle: handle) { $0
                    .id()
                    .handle()
                    .title()
                    .description()
                    .image({ $0
                        .id()
                        .originalSrc()
                    })
                    .products(first: 1) { $0
                        .edges { $0
                            .node { $0
                                .images(first: 1) { $0
                                    .edges { $0
                                        .node { $0
                                            .originalSrc()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    static func queryForOptionsInProduct(in product: ProductModel)-> Storefront.QueryRootQuery {
        return Storefront.buildQuery{ $0
            .shop { $0
                .productByHandle(handle: product.handle) { $0
                    .options { $0
                        .id()
                        .name()
                        .values()
                    }
                    
                }
            }
            
        }
    }
    
    static func queryForVariant(in product: ProductModel, selectedOptions: [Storefront.SelectedOptionInput])-> Storefront.QueryRootQuery {
        return Storefront.buildQuery{ $0
            .shop { $0
                .productByHandle(handle: product.handle) { $0
                    .variantBySelectedOptions(selectedOptions: selectedOptions) {$0
                        .id()
                        .compareAtPrice()
                        .price()
                        .title()
                        .sku()
                        .availableForSale()
                    }
                }
            }
            
        }
    }
    
    
    
    
    // ----------------------------------
    //  MARK: - Checkout -
    //
    static func mutationForCreateCheckout(with cartItems: [CartItemModel]) -> Storefront.MutationQuery {
        let lineItems = cartItems.map { item in
            Storefront.CheckoutLineItemInput.create(quantity: Int32(item.quantity), variantId: GraphQL.ID(rawValue: item.variant.id))
        }
        
        let checkoutInput = Storefront.CheckoutCreateInput.create(
            lineItems: .value(lineItems),
            allowPartialAddresses: .value(true)
        )
        
        return Storefront.buildMutation { $0
            .checkoutCreate(input: checkoutInput) { $0
                .checkout { $0
                    .id()
                    .ready()
                    .requiresShipping()
                    .taxesIncluded()
                    .email()
                    
                    .shippingAddress { $0
                        .firstName()
                        .lastName()
                        .phone()
                        .address1()
                        .address2()
                        .city()
                        .country()
                        .countryCode()
                        .province()
                        .provinceCode()
                        .zip()
                    }
                    
                    .shippingLine { $0
                        .handle()
                        .title()
                        .price()
                    }
                    
                    .note()
                    .lineItems(first: 250) { $0
                        .edges { $0
                            .cursor()
                            .node { $0
                                .variant { $0
                                    .id()
                                    .price()
                                }
                                .title()
                                .quantity()
                            }
                        }
                    }
                    .webUrl()
                    .currencyCode()
                    .subtotalPrice()
                    .totalTax()
                    .totalPrice()
                    .paymentDue()
                }
            }
        }
    }
}


