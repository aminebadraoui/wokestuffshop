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
                        }
                    }
                }
            }
        }
    }
    
    //  fetch products in a specific collection
    static func queryForProducts( in collection: CollectionModel, limit: Int32 = 100, after cursor: String? = nil) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .node(id: collection.model.id) { $0
                .onCollection { $0
                    .products(first: limit) { $0
                        .edges{ $0
                            .node { $0
                                .id()
                                .handle()
                                .title()
                                .description()
                               
               
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
                        }
                    }
                }
            }
}
