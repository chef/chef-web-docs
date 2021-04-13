/*
  Sources of information:
  https://github.com/swiftype/swiftype-search-jquery
  https://github.com/swiftype/swiftype-autocomplete-jquery
  https://github.com/swiftype/swiftype-faceted-search-example
  https://swiftype.com/documentation/site-search/guides/jquery
  https://swiftype.com/documentation/site-search/guides/faceted-search
*/

$(document).ready(function() {

  // Swiftype UI elements //

  var showSearchModal = function() {
    $("#swiftype-modal").show(500);
    $("#swiftype-search-form-modal").focus();
  }

  var hideSearchModal = function() {
    $("#swiftype-modal").hide(250);
    $("#swiftype-custom-facets input:checkbox[class='product-filter']").prop( "checked", false );
    window.location.hash = "";
    $(".swiftype-search-input").val('');
    $("div.swiftype-widget > div.autocomplete").html("<ul></ul>");
  }

  $("#swiftype-close-button").click(function(){
    hideSearchModal();
  });

  $('body').click(function (event) {
    if(!$(event.target).closest('#swiftype-modal-content').length && !$(event.target).is('#swiftype-modal-content')) {
      hideSearchModal();
    }
  });

  $("#swiftype-custom-facets-toggle-button").click(function(){
    if ($(window).width() < 768) {
      $("#swiftype-custom-facets").toggle(500);
      $("#swiftype-custom-facets-toggle-caret").find('svg').toggle();
    }
  });

  $('#swiftype-facet-infra').on('change',function(){
    $('#swiftype-facet-client, #swiftype-facet-server').prop('checked',$(this).prop('checked'));
  });

  // trigger hideCustomFacets function after resize ends
  var debounce = function(fn, interval) {
    let timer;
    return function debounced(...args) {
      clearTimeout(timer);
      timer = setTimeout(function call() {
        fn(...args);
      }, interval);
    };
  }

  var hideCustomFacets = function() {
    if ($(this).width() > 768) {
      $('#swiftype-custom-facets').show();
    } else {
      $('#swiftype-custom-facets').hide();
      $("#swiftype-custom-facets-toggle-caret > svg.fa-caret-down").hide();
      $("#swiftype-custom-facets-toggle-caret > svg.fa-caret-up").show();
    }
  }

  $(window).resize(debounce(hideCustomFacets, 400));

  const searchHashRegex = /^#stq./;
  const searchStringMatchRegex = /^#stq=(.*)/;
  const searchPageNumRegex = /&stp=\d{1,3}$/;


  var processLocationHash = function() {
    var hash = searchStringMatchRegex.exec(window.location.hash)[1];
    pageNumTrue = searchPageNumRegex.exec(hash);
    if (pageNumTrue) {
      var matchString = decodeURIComponent(hash.substring(0,pageNumTrue.index));
    } else {
      var matchString = decodeURIComponent(hash);
    };
    $('input#swiftype-search-form-modal').val(matchString);
  };

  // Watch for hashchange
  // #stq=[whatever]&stp=[number]
  // #stq=release notes&stp=1
  // it matches #stq
  $(window).on('hashchange', function() {
    if (searchHashRegex.test(window.location.hash)) {
      processLocationHash();
      showSearchModal();
    }
  });

  if (searchHashRegex.test(window.location.hash)) {
    processLocationHash();
    showSearchModal();
  };

  // Autocomplete UI elements
  $("input.swiftype-search-input").on('keypress', function (event) {
   if (event.keycode == 13 || event.which == 13) {
      event.preventDefault();
      window.location.hash = 'stq=' + encodeURIComponent($(this).val()) + '&stp=1';
    };
  });

  /////////////////////////
  // Handle Search Results
  /////////////////////////
  var searchConfig = {
    "facets": {}
  };

  /////////
  // Handle Regular Search Results
  /////////
  var resultTemplate = Hogan.compile([
    "<li>",
      "<a class='swiftype-result' href='{{url}}'>",
        "<span class='st-result-title'>{{title}}</span>",
        "<span class='st-result-detail'><span class='st-result-highlight-product'>Product: {{product}} </span>{{{sections}}}<span class='st-result-detail-body'> • {{{body}}}</span></span>",
      "</a>",
    "</li>"
  ].join('') );

  var customRenderFunction = function(document_type, item) {
    var
      data = {
        title: item['title'],
        product: item['chef-product'],
        url: item['url'],
        sections: item['highlight']['sections'],
        body: item.highlight['body'],
      };
    return resultTemplate.render(data);
  };

  // Update the hash value in window.location //
  var reloadResults = function() {
    window.location.hash = window.location.hash.replace(/stp=[^&]*/i, 'stp=1'); // Reset to page 1
    $(window).hashchange();
  };

  //Checking the Infra checkbox will also check the Infra Client and Infra Server checkboxes.
  $('#swiftype-facet-infra').on('change',function(){
    $('#swiftype-facet-client, #swiftype-facet-server').prop('checked',$(this).prop('checked'));
  });

  // When the product facet checkboxes are checked/unchecked, update the array of products and reload the results
  $("#swiftype-custom-facets input:checkbox[class='product-filter']").change(function() {
    searchConfig.facets['chef-products'] = $("#swiftype-custom-facets input:checkbox[name='chef-product']:checked").map(function() {
      return $(this).val()
    }).get();
    reloadResults();
  });

  // Returns an array of the chef-products to filter by
  var readFilters = function () {
    return {
      "page": {
        "chef-product": searchConfig.facets['chef-products'],
      }
    }
  };

  var highlightFields = {
    "page": {
      "sections":{"size": 200, "fallback":true},
      "body":{"size": 250, "fallback": true},
    }
  }

  /////////
  // Handle Autocomplete Search Results
  /////////

  var resultAutocompleteTemplate = Hogan.compile([
    "<a class='swiftype-auto-result' href='{{url}}'>",
      "<span class='swiftype-auto-result-title'>{{title}}</span>",
      "<span class='swiftype-auto-result-detail'>{{{sections}}}</span>",
    "</a>"
  ].join('') );

  var customAutocompleteFunction = function(document_type, item) {
    var
      data = {
        title: item['title'],
        url: item['url'],
        sections: item['highlight']['sections'],
      };
    return resultAutocompleteTemplate.render(data);
  };

  var autoHighlightFields = {
    "page": {
      "sections":{"size": 200, "fallback":true},
      "body":{"size": 250, "fallback": true},
    }
  }

  /*
    The swiftypeSearch function is from the Swiftype jQuery Plugin - "jquery.swiftype.search.js"
    https://swiftype.com/documentation/site-search/guides/jquery
    https://github.com/swiftype/swiftype-search-jquery
  */

  $('#swiftype-search-form-modal').swiftypeSearch({
    resultContainingElement: '#swiftype-search-results',
    engineKey: 'mXqaEKYsv--xS9fcY3Jz',
    renderFunction: customRenderFunction,
    facets: { page: ['chef-product'] },
    filters: readFilters,
    perPage: 8,
    highlightFields: highlightFields,
  });

  /*
    The swiftype function is from the autocomplete plugin - "jquery.swiftype.autocomplete.js"
    https://swiftype.com/documentation/site-search/guides/jquery
    https://github.com/swiftype/swiftype-autocomplete-jquery
  */

  $('.swiftype-search-autocomplete').swiftype({
    engineKey: 'mXqaEKYsv--xS9fcY3Jz',
    highlightFields: autoHighlightFields,
    renderFunction: customAutocompleteFunction,
  });
});
