function filterInspecResources() {
    // Declare variables
    var input, filter, li, a, i, txtValue;
    input = document.getElementById('filter-inspec');
    filter = input.value.toUpperCase();
    li = document.getElementsByClassName("inspec-resource")

    // Loop through all list items, and hide those who do not match the search query
    for (i = 0; i < li.length; i++) {
      a = li[i].getElementsByTagName("a")[0];
      txtValue = a.textContent || a.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        li[i].style.display = "";
      } else {
        li[i].style.display = "none";
      }
    }
}

// This works with inspec_resources_filter shortcode to filter out inspec resources by name
// on https://docs.chef.io/inspec/resources/
// The shortcode should be in inspec/inspec/docs-chef-io/layouts/shortcodes/inspec_resources_filter.html
