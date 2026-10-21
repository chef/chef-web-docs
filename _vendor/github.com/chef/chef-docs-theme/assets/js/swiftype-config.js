/*
  Sources of information:
  https://github.com/swiftype/swiftype-search-jquery
  https://github.com/swiftype/swiftype-autocomplete-jquery
  https://github.com/swiftype/swiftype-faceted-search-example
  https://swiftype.com/documentation/site-search/guides/jquery
  https://swiftype.com/documentation/site-search/guides/faceted-search
*/

$(document).ready(function() {
  // Returns a debounced version of fn that delays invoking it until after
  // interval milliseconds have elapsed since the last call. Resets the timer
  // on every call, so fn only fires once the calls have stopped for interval ms.
  function debounce(fn, interval) {
    let timer;
    return function debounced(...args) {
      clearTimeout(timer);
      timer = setTimeout(function call() {
        fn(...args);
      }, interval);
    };
  }

  // Normalizes the raw data-default-search-keys attribute value into a JavaScript
  // array. Returns the value as-is if it is already an array, attempts JSON.parse
  // if it is a string, and returns an empty array for any other type or on parse error.
  function parseDefaultSearchProducts(searchKeys) {
    if (Array.isArray(searchKeys)) {
      return searchKeys;
    }

    if (typeof searchKeys === 'string') {
      try {
        const parsedSearchKeys = JSON.parse(searchKeys);
        return Array.isArray(parsedSearchKeys) ? parsedSearchKeys : [];
      } catch (error) {
        console.error('Failed to parse default search keys:', error);
        return [];
      }
    }

    return [];
  }

  // Retrieve list of default search product keys from search page HTML and parse into JSON array
  const defaultSearchProducts = $('#swiftype-search').data('default-search-keys');
  const parsedDefaultSearchProducts = parseDefaultSearchProducts(defaultSearchProducts);

  ///////////////////////////////////
  //
  // Search Modal functions
  //
  ///////////////////////////////////

  const isMac = navigator.platform.toUpperCase().includes('MAC');
  const searchModal = document.getElementById('swiftype-modal');

  // Show the shortcut appropriate to the user's platform (Cmd on Mac, Ctrl elsewhere)
  const shortcutHint = document.getElementById('swiftype-search-shortcut-hint');
  if (shortcutHint) {
    shortcutHint.textContent = isMac ? '⌘K' : 'Ctrl+K';
  }

  // Opens the search modal (native <dialog>) and focuses the input. No-ops if
  // already open, since calling showModal() on an open dialog throws.
  function showSearchModal(event) {
    if (!searchModal.open) {
      searchModal.showModal();
    }
    $("#swiftype-search-form-modal-input").focus();
    if (event) {
      event.stopPropagation();
    }
  }

  // Closes the search modal. Input clearing is handled by the dialog's
  // "close" listener below so it also covers Esc and backdrop-click closes.
  function hideSearchModal() {
    if (searchModal.open) {
      searchModal.close();
    }
  }

  // Clear the search input whenever the dialog closes, regardless of cause
  // (close button, Esc key, backdrop click, or a submitted search).
  searchModal.addEventListener('close', function() {
    $('input#swiftype-search-form-modal-input').val('');
  });

  // Clicking directly on the dialog element (i.e. its ::backdrop, since a
  // click on the modal content targets a descendant instead) closes it.
  searchModal.addEventListener('click', function(event) {
    if (event.target === searchModal) {
      hideSearchModal();
    }
  });

  // Hide search modal if clicking close button
  $("#swiftype-search-close-button").click(function(){
    hideSearchModal();
  });

  // Show search modal when clicking on search bar in top nav
  $("#swiftype-search-top-nav").click(function(event){
    showSearchModal(event);
  });

  // Open the search modal from anywhere on the site with Cmd+K (Mac) or Ctrl+K
  $(document).on('keydown', function(event) {
    const target = event.target;
    const isEditableTarget = target && (target.isContentEditable || /^(INPUT|TEXTAREA|SELECT)$/.test(target.tagName));
    if (isEditableTarget) {
      return;
    }
    const shortcutPressed = (isMac ? event.metaKey : event.ctrlKey) && event.key.toLowerCase() === 'k';
    if (shortcutPressed) {
      event.preventDefault();
      showSearchModal(event);
    }
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
      globalThis.location.href = "/search/#stq=" + encodeURIComponent($(this).val()) + '&stp=1';
      hideSearchModal();
    }
  });

  // on clicking modal search button, navigate to search page and submit search string
  $("#swiftype-search-form-modal-input-search").click(function(){
    const searchInput = $("input#swiftype-search-form-modal-input").val();
    globalThis.location.href = "/search/#stq=" + encodeURIComponent(searchInput) + '&stp=1';
    hideSearchModal();
  });

  ///////////////////////////////////
  //
  // search_bar shortcode functions
  //
  ///////////////////////////////////

  // Clear text in the search_bar shortcode's input if the x button is clicked
  $('#search-bar-form-input-clear').click(function() {
    $('input#search-bar-form-input').val('');
    $('input#search-bar-form-input').focus();
  });

  // on clicking the search_bar shortcode's search button, navigate to search page and submit search string
  $('#search-bar-form-input-search').click(function() {
    const searchInput = $('input#search-bar-form-input').val();
    globalThis.location.href = "/search/#stq=" + encodeURIComponent(searchInput) + '&stp=1';
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
    globalThis.location.href = "/search/#stq=" + encodeURIComponent(searchString) + '&stp=1';
   });

  // Shows or hides the product facet filter panel based on viewport width.
  // Above 768px the panel is always visible; below it is hidden with the
  // up-caret toggle shown so the user can expand it manually.
  const hideCustomFacets = function() {
    if ($(globalThis).width() > 768) {
      $('#swiftype-custom-facet-products').show();
      $("#search-facet-product-toggle-caret > svg.fa-caret-down").hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-up").hide();
    } else {
      $('#swiftype-custom-facet-products').hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-down").hide();
      $("#search-facet-product-toggle-caret > svg.fa-caret-up").show();
    }
  };

  $(globalThis).resize(debounce(hideCustomFacets, 400));

  ///////////////////////////////////
  //
  // Search Filter functions
  //
  ///////////////////////////////////

  // When a versioned product checkbox is selected, shows its version dropdown.
  // When deselected, hides the version dropdown. Updates search results either way.
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

  // When a version is selected from a version dropdown, updates search results.
  $('select.search-facet-versions').on('change', function(){
    getChefProducts();
    reloadResults();
  });

  // When the product facet checkboxes are checked/unchecked, update the array of products and reload the results
  $("#swiftype-custom-facets input:checkbox[class='product-filter']").change(function() {
    getChefProducts();
    reloadResults();
  });

  // Resets all product filter checkboxes and hides all version dropdowns,
  // then reloads search results with the default product set.
  $('#swiftype-clear-all-filters').on('click', function() {
    $('#swiftype-custom-facets input[type=checkbox]').prop('checked', false).css('display', 'inline-block');
    $('select.search-facet-versions').css('display', 'none');

    getChefProducts();
    reloadResults();
  });


  const searchHashRegex = /^#stq./;
  const searchStringMatchRegex = /^#stq=(.*)/;
  const searchPageNumRegex = /&stp=\d{1,3}$/;


  // Reads the search string from the URL hash (format: #stq=<query>&stp=<page>)
  // and populates the search input field with the decoded query.
  var processLocationHash = function() {
    const hashMatch = searchStringMatchRegex.exec(globalThis.location.hash);

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

  // Watches for URL hash changes and calls processLocationHash when the hash
  // matches the search format (#stq=<query>&stp=<page>).
  $(globalThis).on('hashchange', function() {
    if (searchHashRegex.test(globalThis.location.hash)) {
      processLocationHash();
    }
  });

  if (searchHashRegex.test(globalThis.location.hash)) {
    processLocationHash();
  };

  // On narrow viewports (below 860px), toggles the product facet panel
  // and flips the caret icon direction when the Products heading is clicked.
  $("#search-facet-product").click(function() {
    if ($(globalThis).width() < 860) {
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

  // Renders a single Swiftype search result as an HTML list item using the
  // Hogan template. Includes the title, product tag, and highlighted excerpts
  // for the sections and body fields if available.
  const customRenderFunction = function(_documentType, item) {
    const data = {
        title: item['title'],
        product: item['chef-product'],
        url: item['url'],
        sections: item.highlight?.sections ?? '',
        body: item.highlight?.body ?? '',
      };
    return resultTemplate.render(data);
  };

  // Builds a windowed list of page numbers to display: always the first and
  // last page, plus up to `delta` pages on either side of the current page,
  // with "..." markers standing in for any gaps between them.
  const getPaginationRange = function(current, total, delta = 2) {
    const range = [];
    for (let page = 1; page <= total; page += 1) {
      if (page === 1 || page === total || (page >= current - delta && page <= current + delta)) {
        range.push(page);
      }
    }

    const rangeWithEllipses = [];
    let previousPage;
    range.forEach((page) => {
      if (previousPage !== undefined && page - previousPage > 1) {
        rangeWithEllipses.push('...');
      }
      rangeWithEllipses.push(page);
      previousPage = page;
    });

    return rangeWithEllipses;
  };

  // Renders the "« previous", numbered page links, and "next »" pagination
  // controls. Page-number links reuse the plugin's own [data-hash][data-page]
  // click handler (see jquery.swiftype.search.js), so no extra JS wiring is needed.
  const customRenderPaginationForType = function(_documentType, currentPage, totalPages) {
    currentPage = parseInt(currentPage, 10);
    totalPages = parseInt(totalPages, 10);

    let html = '<div class="st-page">';

    if (currentPage !== 1) {
      html += `<a href="#" class="st-prev" data-hash="true" data-page="${currentPage - 1}">&laquo; previous</a>`;
    }

    html += '<div class="st-page-numbers">';
    getPaginationRange(currentPage, totalPages).forEach((page) => {
      if (page === '...') {
        html += '<span class="st-page-ellipsis">&hellip;</span>';
      } else if (page === currentPage) {
        html += `<span class="st-page-number is-current" aria-current="page">${page}</span>`;
      } else {
        html += `<a href="#" class="st-page-number" data-hash="true" data-page="${page}">${page}</a>`;
      }
    });
    html += '</div>';

    if (currentPage < totalPages) {
      html += `<a href="#" class="st-next" data-hash="true" data-page="${currentPage + 1}">next &raquo;</a>`;
    }

    html += '</div>';
    return html;
  };

  // Resets the URL hash to page 1 and triggers a hashchange event to
  // reload search results with the current query and filters.
  var reloadResults = function() {
    // Reset window to page 1
    if (/stp=[^&]*/i.test(globalThis.location.hash)) {
      globalThis.location.hash = globalThis.location.hash.replace(/stp=[^&]*/i, 'stp=1');
    } else if (globalThis.location.hash) {
      globalThis.location.hash = globalThis.location.hash + '&stp=1';
    } else {
      globalThis.location.hash = '#stp=1';
    }

    $(globalThis).hashchange();
  };

  // Updates searchConfig.facets['chef-products'] with the currently selected
  // product checkboxes and version dropdowns. Falls back to the default product
  // list when no checkboxes are checked.
  const getChefProducts = function(){
    if ($('#swiftype-product-filters :checkbox:checked').length === 0) {
      searchConfig.facets['chef-products'] = parsedDefaultSearchProducts;
    } else {
      searchConfig.facets['chef-products'] = $("#swiftype-custom-facets input:checkbox[name='chef-product']:checked, select.search-facet-versions:visible option:selected").map(function() {
        return $(this).val();
      }).get();
    }
  };


  // Returns the filters object passed to Swiftype on each search, scoping
  // results to the currently selected set of chef-product values.
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
    renderPaginationForType: customRenderPaginationForType,
    facets: { page: ['chef-product'] },
    filters: readFilters,
    perPage: 10,
    highlightFields: highlightFields,
  });

});
