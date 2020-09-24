// Fetch the given URL parameters
$.urlParam = function(name){
  var results = new RegExp('[\?&]' + name + '=([^]*)').exec(window.location.href);
  if (results==null){
      return null;
  }
  else{
      return results[1] || 0;
  }
}

var version = $.urlParam('v');
console.log(version)


var id = document.getElementById("chef_product_version_select");
var versionList = id.getElementsByTagName("OPTION");
// console.log(versionList)
for (var i = 0; i < versionList.length; i++) {
  console.log(versionList[i].value)
  if (versionList[i].dataset.product == "chef-automate"){
    versionList[i].innerHTML = "Chef Automate " + versionList[i].dataset.version;
  }
  else if (versionList[i].dataset.product == "chef-client"){
    versionList[i].innerHTML = "Chef Infra Client " + versionList[i].dataset.version;
  }
  else if (versionList[i].dataset.product == "chef-server"){
    versionList[i].innerHTML = "Chef Infra Server " + versionList[i].dataset.version;
  }
}


var default_version = document.getElementById("chef_product_version_select").dataset.defaultVersion;
  // console.log(default_version)

var currentVersion = default_version;

versioned_text_blocks = document.getElementsByClassName("chef-product-version")
for (var i = 0; i < versioned_text_blocks.length; i++) {
  versioned_text = versioned_text_blocks[i];
  versioned_text_version = versioned_text_blocks[i].classList[1];
  //console.log(versioned_text_version);
  //console.log(versioned_text.style);

  if (versioned_text_version === default_version) {
    versioned_text.style.display = "block";
  } else {
    versioned_text.style.display = "none";
  }
}

document.getElementsByClassName("chef-product-version")


function changeDefaultVersion(versionInput){
  var default_version = versionInput;
};

document.getElementById("chef_product_version_select").onchange = function() {
  var changeValue = this.value;
  // var urlVersion = $.urlParam('v');
  console.log('New version -->' + changeValue)

  // if (urlVersion === null){
  //   window.location.href = window.location.href + "?v=" + changeValue;
  // } else {
  //   window.location.href = window.location.href.replace(urlVersion, changeValue);
  // };

  if (changeValue == currentVersion){
    console.log( "Selection didn't change version: " + this.value);
  } else {
    oldVersion = currentVersion;
    currentVersion = changeValue;

    displayText = document.getElementsByClassName(currentVersion);

    for(var i = 0; i < displayText.length; i++) {
      displayText[i].style.display = 'block';
    }

    hideText = document.getElementsByClassName(oldVersion);

    for(var i = 0; i < hideText.length; i++) {
      hideText[i].style.display = 'none';
    }
  }
};
