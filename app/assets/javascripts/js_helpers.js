function attachListeners(){
  $('.to_library').on('click', function(e){
    e.preventDefault();
    stopAudio()
    loadScalesLibrary();
  })
  $('.to_practice_room').on('click', function(e){
    e.preventDefault();
    stopAudio()
    loadPracticeRoom();
  })
}

function primaryHeader(headerText){
  $('.header').text(headerText);
}

function primaryContent(content){
  $('.primary_content').html(content);
}

function primaryContentAdd(content){
 $('.primary_content').append(content)
}

function sbHeader(headerText){
  $('.sb_header').html('<h1>' + headerText + '</h1>');
}

function sbContent(content){
  $('.sb_content').html(content);
}

function sbContentAdd(content){
  $('.sb_content').append(content);
}

function sbNavStart(content){
  $('.sb_nav').html(content)
}

function sbNavAdd(content){
  $('.sb_nav').append(content)
}

function linkWithId(id, text){
  return '<a id="' + id + '" href="#">' + text + '</a>'
}

function addNavListener(id, func, args){
  $('#' + id).on('click', function(e){
    e.preventDefault();
    func.apply(this, args)
  })
}
