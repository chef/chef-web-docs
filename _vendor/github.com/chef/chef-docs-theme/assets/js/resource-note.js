// Show and hide note at top of each resource page telling
// users where they can edit resource page YAML files

function resource_note_function(elementID) {
  var e = document.getElementById(elementID);
  e.style.display = e.style.display === 'block' ? 'none' : 'block';
}
