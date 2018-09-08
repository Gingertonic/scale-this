class Scale{
  constructor(attr){
    this.id = attr.id;
    this.name = attr.name;
    this.scaleType = attr.scale_type;
    this.origin = attr.origin;
    this.melodyRules = attr.melody_rules;
    this.private = attr.private;
    this.pattern = attr.pattern;
    this.aka = attr.aka;
    this.createdBy = attr.created_by;
  }

  scaleTypeSlug(){
    return this.scaleType.replace(/\W/g, "_");
  }

  renderLiLink(){
    return `<li><a class="scale_link" id="${this.slugify()}" href="#">${this.name}</a></li>`
  }

  slugify(){
    return this.name.replace(new RegExp(" ", "g"), "-").replace("#", "sharp");
  }

  renderScaleTypeBlock(){
    return `<div class="scale_type" id="${this.scaleTypeSlug()}">
      <h4>${this.scaleType}</h4>
    </div>`
  }

  patternFrom(root){
    let patternFrom = [root];
    [...this.pattern].forEach(function(diff){
      patternFrom.push(patternFrom[patternFrom.length - 1] + parseInt(diff))
    });
    return patternFrom;
  }

}
