class ES_Product_Service
  INDEX = "products"
  def es_add_product(product) # the product here is ruby objects
    ELASTIC_CLIENT.index(
      index: INDEX,
      id: product.id.to_s,
      body: document_body(product)
    )
  end

  # deletes a document from the index
  def es_delete_product(id)
    ELASTIC_CLIENT.delete(
      index: INDEX,
      id: id.to_s
    )
  end

  def document_body(product)
    {
      name: product.name,
     price: product.price,
     is_available: product.is_available,
     description: product.description
    }
  end

  def es_search_product(query)
    res = ELASTIC_CLIENT.search(
      index: INDEX,
      body:{
        query:{
          multi_match:{
            query: query,
            fields: ["name^2", "description"],
          }
        }
      }
    )

    res["hits"]["hits"].map do |hit|
      hit["_source"].merge(
        id: hit["_id"]
      )

    end
  end
end