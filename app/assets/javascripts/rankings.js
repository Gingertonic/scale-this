//  GET RANKINGS
function loadRankings(){
  clearErrors();
  rankingNav();
  sbHeader("Current Rankings!")
  getRankingsData();
}

function rankingNav(){
  $.get('/current_username', function(user){
    if (!user) {
      sbNavStart("")
    } else {
      sbNavStart(linkWithId("add_scale", "Add a New Scale"))
      addNavListener("add_scale", loadNewScaleForm)
    }
  })
}

function getRankingsData(){
  $.get('/musicians/rankings/total-practises', function(resp){
    var musicians = []
    resp["data"].forEach(function(muso){
      musicians.push(new Musician(muso))
    })
    let rankingsTable = HandlebarsTemplates['musician_rankings']({musicians: musicians});
    sbContent(rankingsTable);
  })
}
