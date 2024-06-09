abstract class BaseSerializer < Lucky::Serializer
  def self.for_collection_with_paginate(collection : Enumerable, pages : Lucky::Paginator, *args, **named_args)
    {
      "data" => collection.map do |object|
        new(object, *args, **named_args)
      end,
      "pageInfo" => {
        next:            pages.path_to_next,
        previous:        pages.path_to_previous,
        hasNextPage:     pages.path_to_next.nil?.!,
        hasPreviousPage: pages.path_to_previous.nil?.!,
        count:           pages.item_count,
        total:           pages.total,
      },
    }
  end

  def self.for_collection(collection : Enumerable, *args, **named_args)
    collection.map do |object|
      new(object, *args, **named_args)
    end
  end

  def self.nested_key_data(record, *args, **named_args)
    {
      "data": new(record, *args, **named_args),
    }
  end
end
