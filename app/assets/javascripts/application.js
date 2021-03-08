//= require jquery
//= require jquery.validate
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    if (document.getElementById("contact-form")) {
        $("#contact-form").validate({
            rules: {
                'contact[title]': 'required',
                'contact[body]': 'required'
            },
            messages: {
                'contact[title]': 'This field is required',
                'contact[body]': 'This field is required'
            }
        });
    }
});