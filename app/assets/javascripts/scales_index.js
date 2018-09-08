// SCALES INDEX VIEW
//LOAD SCALES INDEX
function loadScalesLibrary(){
  primaryHeader("SCALES LIBRARY");
  loadScales();
  loadRankings();
}

// GET SCALES

function clearPrimaryContent(){
  clearErrors();
  primaryContent("")
}

function loadScales(){
  clearPrimaryContent();
  $.get('/scales', function(resp){
  }, 'json').done(function(resp){
    sortScales(resp["data"])
  })
}

function sortScales(scales){
  scales.forEach(function(scale){
    let new_scale = new Scale(scale.attributes)
    addToIndex(new_scale)
  })
}

// function sortByDim(){
//   clearPrimaryContent();
//   $.get('/scales', function(resp){
//   }, 'json').done(function(resp){
//     let scales = resp["data"];
//     let dims = scales.filter(function(scale){
//       return (scale.attributes.name).includes("dim")
//     })
//     dims.forEach(function(scale){
//       let new_scale = new Scale(scale.attributes);
//       addToIndex(new_scale);
//     })
//   })
// }



// Return scales with 'dim' in

function addToIndex(new_scale){
  if ($(`#${new_scale.scaleTypeSlug()}`).length === 0) {
    primaryContentAdd(new_scale.renderScaleTypeBlock())
  }
  $(`#${new_scale.scaleTypeSlug()}`).append(new_scale.renderLiLink());
  addGoToScaleListener($(`#${new_scale.slugify()}`));
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
