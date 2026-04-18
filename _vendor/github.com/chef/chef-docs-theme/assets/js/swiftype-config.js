/*
  Sources of information:
  https://github.com/swiftype/swiftype-search-jquery
  https://github.com/swiftype/swiftype-autocomplete-jquery
  https://github.com/swiftype/swiftype-faceted-search-example
  https://swiftype.com/documentation/site-search/guides/jquery
  https://swiftype.com/documentation/site-search/guides/faceted-search
*/

$(document).ready(function() {

  // Retrieve list of default search product keys from search page HTML and parse into JSON array
  const defaultSearchProducts = $('#swiftype-search').data('default-search-keys');

  function parseDefaultSearchProducts(searchKeys) {
    if (Array.isArray(searchKeys)) {
      return searchKeys;
    }

    if (typeof searchKeys === 'string') {
      try {
        const parsedSearchKeys = JSON.parse(searchKeys);
        return Array.isArray(parsedSearchKeys) ? parsedSearchKeys : [];
      } catch (error) {
        return [];
      }
    }

    return [];
  }

  const parsedDefaultSearchProducts = parseDefaultSearchProducts(defaultSearchProducts);

  ///////////////////////////////////
  //
  // Search Modal functions
  //
  ///////////////////////////////////

  function showSearchModal(event) {
    $("#swiftype-modal").show(250);
    $("#swiftype-search-form-modal-input").focus();
    event.stopPropagation();
  }

  function hideSearchModal() {
    $("#swiftype-modal").hide(250);
    $('input#swiftype-search-form-modal-input').val('');
  }

  // Hide search modal if clicking close button
  $("#swiftype-search-close-button").click(function(){
    hideSearchModal();
  });

  // Hide search modal if it's already visible and click outside modal box
  $('body').on('click', function(event) {
    if ($('#swiftype-modal').is(':visible') && !$(event.target).closest("#swiftype-modal").length) {
      hideSearchModal();
    }
  });

  // Show search modal when clicking on search bar in top nav
  $("#swiftype-search-top-nav").click(function(event){
    showSearchModal(event);
  });

  // Clear text in search modal if x button is clicked
  $('#swiftype-search-form-modal-input-clear').click(function() {
    $('input#swiftype-search-form-modal-input').val('');
    $('input#swiftype-search-form-modal-input').focus();
  });

  // on pressing enter key, navigate to search page and submit search string
  $("input.swiftype-search-input").on('keypress', function(event) {
    if (event.key === 'Enter' || event.which === 13) {
      event.preventDefault();
      window.location.href = "/search/#stq=" + encodeURIComponent($(this).val()) + '&stp=1';
      hideSearchModal();
    }
  });

  // on clicking modal search button, navigate to search page and submit search string
  $("#swiftype-search-form-modal-input-search").click(function(){
    const searchInput = $("input#swiftype-search-form-modal-input").val();
    window.location.href = "/search/#stq=" + encodeURIComponent(searchInput) + '&stp=1';
    hideSearchModal();
  });

  ///////////////////////////////////
  //
  // Search Input functions
  //
  ///////////////////////////////////

  // If x button next to input is clicked:
  // Clear search input
  // Reset search in URL
  // Reset search results
  $('input#swiftype-search-top-container-form-input-clear').click(function() {
    $('input#swiftype-search-top-container-form-input').val('');
    $('input#swiftype-search-top-container-form-input').focus();
    history.pushState({page: "Chef Documentation Search"}, "", "/search/");
  });

  $("input#swiftype-search-top-container-form-input-search").on('click', function() {
    const searchString = $('input#swiftype-search-top-container-form-input').val();
    window.location.href = "/search/#stq=" + encodeURIComponent(searchString) + '&stp=1';
   });

  // trigger hideCustomFacets function after resize ends
  const debounce = function(fn, interval) {
    let timer;
    return function debounced(...args) {
      clearTimeout(timer);
      timer = setTimeout(function call() {
        fn(...args);
      }, interval);
    };
  };

  // show and hide elements when resizing
  const hideCustomFacets = function() {
    if ($(window).width() > 768) {
      $('#swiftype-custom-facet-products').show();
      $("#search-facet-product-toggle-caret > svg.fa-caret-down").hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-up").hide();
    } else {
      $('#swiftype-custom-facet-products').hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-down").hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-up").show();
    }
  };

  $(window).resize(debounce(hideCustomFacets, 400));

  ///////////////////////////////////
  //
  // Search Filter functions
  //
  ///////////////////////////////////

  // On selecting a checkbox for a versioned product:
  // 1. display the version select tag

  // On deselecting a checkbox for a versioned product
  // selected versioned checkboxes are deselected
  $('.swiftype-product-with-versions').on('change', function(){

    const versionListId = $($(this).data('version-selector-id'));

    if ($(this).is(':checked')) {
      versionListId.show();
    } else {
      versionListId.hide();
    }

    getChefProducts();
    reloadResults();
  });

  // When selecting a version option
  // 1. regenerate results
  $('select.search-facet-versions').on('change', function(){
    getChefProducts();
    reloadResults();
  });

  // When the product facet checkboxes are checked/unchecked, update the array of products and reload the results
  $("#swiftype-custom-facets input:checkbox[class='product-filter']").change(function() {
    getChefProducts();
    reloadResults();
  });

  // "Clear all" button resets search filters
  // show hidden products
  // hide version checkboxes
  // uncheck everything
  // reload results
  $('#swiftype-clear-all-filters').on('click', function() {
    $('#swiftype-custom-facets input[type=checkbox]').prop('checked', false).css('display', 'inline-block');
    $('select.search-facet-versions').css('display', 'none');

    getChefProducts();
    reloadResults();
  });


  const searchHashRegex = /^#stq./;
  const searchStringMatchRegex = /^#stq=(.*)/;
  const searchPageNumRegex = /&stp=\d{1,3}$/;


  var processLocationHash = function() {
    const hashMatch = searchStringMatchRegex.exec(window.location.hash);

    if (!hashMatch) {
      return;
    }

    const hash = hashMatch[1];
    const pageNumMatch = searchPageNumRegex.exec(hash);
    const matchString = pageNumMatch
      ? decodeURIComponent(hash.substring(0, pageNumMatch.index))
      : decodeURIComponent(hash);

    $('input#swiftype-search-top-container-form-input').val(matchString);
  };

  // Watch for hashchange
  // #stq=[whatever]&stp=[number]
  // #stq=release notes&stp=1
  // it matches #stq
  $(window).on('hashchange', function() {
    if (searchHashRegex.test(window.location.hash)) {
      processLocationHash();
    }
  });

  if (searchHashRegex.test(window.location.hash)) {
    processLocationHash();
  };

  $("#search-facet-product").click(function() {
    if ($(window).width() < 860) {
      $("#swiftype-custom-facet-products").toggle(500);
      $("#search-facet-product-toggle-caret").find('svg').toggle();
    }
  });

  /////////////////////////
  // Handle Search Results
  /////////////////////////
  const searchConfig = {
    "facets": {}
  };

  // Define default products used in search
  searchConfig.facets['chef-products'] = parsedDefaultSearchProducts;

  const resultTemplate = Hogan.compile([
    "<li>",
      "<a class='swiftype-result' href='{{url}}'>",
        "<span class='st-result-title'>{{title}}</span>",
        "<span class='st-result-highlight-product'>Product: {{product}} </span>",
        "<span class='st-result-sections detail'>{{{sections}}}</span>",
        "<span class='st-result-detail-body detail'>{{{body}}}</span>",
      "</a>",
    "</li>"
  ].join('') );

  var customRenderFunction = function(_documentType, item) {
    const data = {
        title: item['title'],
        product: item['chef-product'],
        url: item['url'],
        sections: item.highlight && item.highlight.sections ? item.highlight.sections : '',
        body: item.highlight && item.highlight.body ? item.highlight.body : '',
      };
    return resultTemplate.render(data);
  };

  // Update the hash value in window.location
  var reloadResults = function() {
    // Reset window to page 1
    if (/stp=[^&]*/i.test(window.location.hash)) {
      window.location.hash = window.location.hash.replace(/stp=[^&]*/i, 'stp=1');
    } else if (window.location.hash) {
      window.location.hash = window.location.hash + '&stp=1';
    } else {
      window.location.hash = '#stp=1';
    }

    $(window).hashchange();
  };

  // Get all Chef products selected in product checkbox field
  // If no checkboxes are selected, return the default list of products
  const getChefProducts = function(){
    if ($('#swiftype-product-filters :checkbox:checked').length === 0) {
      searchConfig.facets['chef-products'] = parsedDefaultSearchProducts;
    } else {
      searchConfig.facets['chef-products'] = $("#swiftype-custom-facets input:checkbox[name='chef-product']:checked, select.search-facet-versions:visible option:selected").map(function() {
        return $(this).val();
      }).get();
    }
  };


  // Returns an array of the chef-products to filter by
  var readFilters = function () {
    return {
      "page": {
        "chef-product": searchConfig.facets['chef-products'],
      }
    }
  };

  const highlightFields = {
    "page": {
      "sections":{"size": 200, "fallback":true},
      "body":{"size": 250, "fallback": true},
    }
  };

  /*
    The swiftypeSearch function is from the Swiftype jQuery Plugin - "jquery.swiftype.search.js"
    https://swiftype.com/documentation/site-search/guides/jquery
    https://github.com/swiftype/swiftype-search-jquery
  */

  $('#swiftype-search-top-container-form-input').swiftypeSearch({
    resultContainingElement: '#swiftype-search-results',
    engineKey: 'mXqaEKYsv--xS9fcY3Jz',
    renderFunction: customRenderFunction,
    facets: { page: ['chef-product'] },
    filters: readFilters,
    perPage: 10,
    highlightFields: highlightFields,
  });

});
