document.addEventListener('turbolinks:load', function() {
  "use strict"; // Start of use strict

  $('#nav-tab a').on('click', function (e) {
    e.preventDefault()
    $(this).tab('show')
  })
}) // End of use strict
