Ext.onReady(function() {
  Ext.select("input.account_ids").addListener("change", function(e,el){
    // is the checkbox ticked?
    if(e.target.checked) {
      // yes - add value
      add_value(e.target.value);
    } else {
      // no - remove value
      remove_value(e.target.value);
    }
    
  });
});

function add_value(val) {
  var vals = Ext.get("flyer_account_ids").dom.value.split(",");
  if(vals[0] != "") {
    if(value_present(val, vals)) {
      //console.log("value is here");
      //console.log("doing nothing");
    } else {
      //console.log("value not here");
      //console.log("adding value");
      if(vals[0] == "") {
        Ext.get("flyer_account_ids").dom.value = val;
      } else {
        Ext.get("flyer_account_ids").dom.value = Ext.get("flyer_account_ids").dom.value + "," + val;
      }
    }
  } else {
    //console.log("adding value");
    Ext.get("flyer_account_ids").dom.value = val;
  }
}

function remove_value(val) {
  var vals = Ext.get("flyer_account_ids").dom.value.split(",");
  if(vals[0] != "") {
    if(value_present(val, vals)) {
      //console.log("value is here");
      //console.log("removing value");
      Ext.get("flyer_account_ids").dom.value = Ext.get("flyer_account_ids").dom.value.replace(val,"");
    } else {
      //console.log("value not here");
      //console.log("doing nothing");
    }
  } else {
    //console.log("nothing to do");
  }
}


function value_present(v,a) {
  for(var i=0;i<a.length;i++) {
    if(a[i] == v) {
      return true;
    }
  }
  return false;
}