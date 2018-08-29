function attachListeners(){
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $('.to_library').on('click', function(e){
    e.preventDefault();
    loadScalesLibrary();
  })
  $('.to_practice_room').on('click', function(e){
    e.preventDefault();
    loadPracticeRoom();
  })
}

// SCALES INDEX VIEW
//LOAD SCALES INDEX
function loadScalesLibrary(){
  $('.header').text("SCALES LIBRARY");
  loadScales();
  loadRankings();
}
// GET SCALES
function loadScales(){
  $('.primary_content').html("")
  $.get('/scales.json', function(resp){
    resp["data"].forEach(function(scale){
      new_scale = new Scale(scale.attributes)
      console.log(new_scale)
      if ($('#' + new_scale.scaleTypeSlug()).length === 0) {
        $('.primary_content').append(new_scale.renderScaleTypeBlock());
      }
      $('#' + new_scale.scaleTypeSlug()).append(new_scale.renderLiLink());
      addGoToScaleListener($('#' + new_scale.slugify()));
    })
  })
}
// ADD LINKS
function addGoToScaleListener(link){
  link.on('click', function(e){
    e.preventDefault();
    loadScaleShow(link[0].id)
  })
}

//  GET RANKINGS
function loadRankings(){
  $('.sb_nav').html('<button class="add_scale sidebar_link"><a href="/scales/new">Add a New Scale</a></button>');
  $('.sb_header').html('<h1>Current Rankings!</h1>');
  $('.add_scale').on('click', function(e){
    e.preventDefault();
    loadNewScaleForm();
  })
  $.get('/musicians/rankings/total-practises', function(resp){
    console.log(resp);
    $('.sb_content').text(resp["data"]);
    var musicians = []
    resp["data"].forEach(function(muso){
      musicians.push(new Musician(muso))
    })
    let rankingsTable = HandlebarsTemplates['musician_rankings']({musicians: musicians});
    $('.sb_content').html(rankingsTable);
  })
}
// NEW SCALE FORM
function loadNewScaleForm(){
  $.get('/scales/new', function(resp){
    scaleForm = HandlebarsTemplates['scale_form']({scale: resp})
    $('.sb_content').html(scaleForm)
  })
  $('.sb_nav').html('<button class="see_rankings sidebar_link"><a href="/musicans/rankings">See rankings!</a></button>');
  $('.sb_header').html('<h1>New Scale</h1>');
  $('.see_rankings').on('click', function(e){
    e.preventDefault();
    loadRankings();
  })
}

$( document ).ready(function() {
    attachListeners();
    loadScalesLibrary();
  });
