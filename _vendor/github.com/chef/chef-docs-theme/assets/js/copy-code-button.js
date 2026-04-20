// Resets a copy button's visible label and aria-label back to the default
// 'Copy' state after a successful copy or error.
function resetButton(button) {
  button.textContent = 'Copy';
  button.setAttribute('aria-label', 'Copy code to clipboard');
}

// Adds a toolbar above every <pre><code> block on the page. The toolbar shows
// the detected code language and a Copy button that writes the block's text to
// the clipboard. On success the button reads 'Copied!' for 2 seconds before
// resetting; on failure it reads 'Error' for 2 seconds before resetting.
// Accepts a clipboard object (navigator.clipboard or a polyfill) so the same
// function works in both native and polyfill environments.
function addCopyButtons(clipboard) {
  document.querySelectorAll('pre > code').forEach(function (codeBlock) {
    // Extract the language name from the CSS class (e.g. 'language-ruby' → 'ruby').
    const langClass = Array.from(codeBlock.classList).find(function (cls) {
      return cls.startsWith('language-');
    });
    const language = langClass ? langClass.replace('language-', '') : '';

    // Build toolbar: [ language label ] ............. [ Copy button ]
    const toolbar = document.createElement('div');
    toolbar.className = 'code-toolbar';

    const langLabel = document.createElement('span');
    langLabel.className = 'code-language';
    langLabel.textContent = language;
    toolbar.appendChild(langLabel);

    const button = document.createElement('button');
    button.className = 'copy-code-button';
    button.type = 'button';
    button.setAttribute('aria-label', 'Copy code to clipboard');
    button.textContent = 'Copy';

    button.addEventListener('click', function () {
      clipboard.writeText(codeBlock.textContent).then(
        function () {
          // Update both the visible label and aria-label so screen readers
          // announce the confirmation (WCAG 4.1.3 Status Messages).
          // Do NOT blur — removing focus programmatically disorients keyboard
          // users by losing their place in the page (WCAG 2.4.3).
          button.textContent = 'Copied!';
          button.setAttribute('aria-label', 'Copied to clipboard');
          setTimeout(resetButton.bind(null, button), 2000);
        },
        function (error) {
          button.textContent = 'Error';
          button.setAttribute('aria-label', 'Failed to copy code');
          console.error('Failed to copy code:', error);
          // Reset so the button doesn't stay in an error state indefinitely.
          setTimeout(resetButton.bind(null, button), 2000);
        }
      );
    });

    toolbar.appendChild(button);

    // Insert the toolbar directly before the <pre> block, or before the
    // Hugo-generated .highlight wrapper when one is present.
    const pre = codeBlock.parentNode;
    if (pre.parentNode.classList.contains('highlight')) {
      const highlight = pre.parentNode;
      highlight.parentNode.insertBefore(toolbar, highlight);
    } else {
      pre.parentNode.insertBefore(toolbar, pre);
    }
  });
}

// Use the native Clipboard API when available; otherwise load a polyfill from
// a CDN and initialise the buttons once the polyfill script has loaded.
if (navigator && navigator.clipboard) {
  addCopyButtons(navigator.clipboard);
} else {
  const script = document.createElement('script');
  script.src =
    'https://cdnjs.cloudflare.com/ajax/libs/clipboard-polyfill/2.7.0/clipboard-polyfill.promise.js';
  script.integrity = 'sha256-waClS2re9NUbXRsryKoof+F9qc1gjjIhc2eT7ZbIv94=';
  script.crossOrigin = 'anonymous';

  script.onload = function () {
    addCopyButtons(clipboard);
  };

  document.body.appendChild(script);
}