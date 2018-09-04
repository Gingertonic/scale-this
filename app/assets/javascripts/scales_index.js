// SCALES INDEX VIEW
//LOAD SCALES INDEX
function loadScalesLibrary(){
  primaryHeader("SCALES LIBRARY");
  loadScales();
  loadRankings();
}

// GET SCALES
function loadScales(){
  clearErrors();
  primaryContent("")
  $.get('/scales.json', function(resp){
  }).done(function(resp){
    sortScales(resp["data"])
  })
}

function sortScales(scales){
  scales.forEach(function(scale){
    new_scale = new Scale(scale.attributes)
    if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
      primaryContentAdd(new_scale.renderScaleTypeBlock())
    }
    $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
    addGoToScaleListener($('#' + new_scale.slugify()));
  })
}

// ADD LINKS
function addGoToScaleListener(link){
  link.on('click', function(e){
    e.preventDefault();
    loadScaleShow(link[0].id)
  })
}


$( document ).ready(function() {
  if (window.location.pathname === '/scales') {
    attachListeners();
    loadScalesLibrary();
  }
  if (window.location.hash === '#practise_room') {
    attachListeners();
    loadPracticeRoom();
  }
});
