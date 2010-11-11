case Padrino.env
  when :development then COUCHDB_NAME = 'flyers_development'
  when :production  then COUCHDB_NAME = 'flyers_production'
  when :test        then COUCHDB_NAME = 'flyers_test'
end
COUCHDB = CouchRest.database!(COUCHDB_NAME)
