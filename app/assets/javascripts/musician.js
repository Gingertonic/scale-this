function Musician(attr){
  this.name = attr.attributes.name;
  this.admin = attr.attributes.admin;
  this.practises = attr.relationships.practises.data;
}

Musician.prototype.totalPractises = function(){
  var totalExperience = 0
  this.practises.forEach(function(practise){
     totalExperience += practise.experience;
   })
   return totalExperience
}
