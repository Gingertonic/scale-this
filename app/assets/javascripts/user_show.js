// SHOW USER
function loadPracticeRoom(){
  clearErrors();
  $.get('/current_username', function(username){
    $.get(`/${username}`, function(resp){
      musician = new Musician(resp["data"]);
      primaryHeader(`${musician.name}'s Practice Room`)
      $.get(`/musicians/${musician.id}/practise_log`, function(pLog){
        const practiseLog = HandlebarsTemplates['practise_log']({log: pLog})
        primaryContent(practiseLog)
        sortPractiseLog(pLog)
      });
      loadMusicianInfo(musician);
    })
  })
}

function sortPractiseLog(pLog){
  for (const period in pLog){
    for (let i = 0; i < pLog[period].length; i++){
      $.get(`/scales/${pLog[period][i]["scale_id"]}`, function(scale){
        let thisScale = new Scale(scale);
        $(`.${period.replace(" ","_").replace("!","")}`).append(thisScale.renderLiLink());
        addGoToScaleListener($(`#${thisScale.slugify()}`));
      })
    }
  }
}


function loadMusicianInfo(musician){
  clearErrors();
  sbNavStart("")
  sbHeader("")
  const musicianInfo = HandlebarsTemplates['musician_info']({musician: musician});
  sbContent(musicianInfo)
}
