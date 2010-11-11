class Flyer < CouchRest::Model::Base
  use_database COUCHDB

  unique_id :id
  # property <name>
  property :file_name, String
  collection_of :account
end
