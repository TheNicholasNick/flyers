class Flyer < CouchRest::Model::Base
  use_database COUCHDB

  unique_id :id
  # property <name>
  property :file_name
  property :account_ids
  
  view_by :account, :map => <<MAP
function(doc) {
  if(doc["couchrest-type"] == "Flyer" && doc.account_ids) {
    doc.account_ids.forEach(function(account){    
      for(real_name in doc["_attachments"]){
        emit(account, [doc.file_name, real_name]);
      }
    });
  }
}
MAP

end
