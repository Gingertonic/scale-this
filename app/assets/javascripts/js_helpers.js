function attachListeners(){
  $('.to_library').on('click', function(e){
    e.preventDefault();
    stopAudio();
    loadScalesLibrary();
    showSearchBar();
  });
  $('.to_practice_room').on('click', function(e){
    e.preventDefault();
    hideSearchBar();
    stopAudio();
    loadPracticeRoom();
  });
  $('form#search').on('submit', function(e){
    e.preventDefault();
    searchScales();
  });
};

const primaryHeader = headerText => $('.header').text(headerText);

const primaryContent = content => $('.primary_content').html(content);

const primaryContentAdd = content => $('.primary_content').append(content);

const sbHeader = headerText =>  $('.sb_header').html(`<h1>${headerText}</h1>`);

const sbContent = content => $('.sb_content').html(content);

const sbContentAdd = content =>  $('.sb_content').append(content);

const sbNavStart = content => $('.sb_nav').html(content);

const sbNavAdd = content => $('.sb_nav').append(`   |   ${content}`);

const linkWithId = (id, text) => `<a id="${id}" href="#">${text}</a>`;

const showSearchBar = () => $('form#search').show();

function hideSearchBar(){
  $('input#search').val("");
  $('form#search').hide();
};

function addNavListener(id, func, args){
  $(`#${id}`).on('click', function(e){
    e.preventDefault();
    func.apply(this, args);
  });
};
