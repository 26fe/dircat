var counter = images.length;
function onload_images() {
  --counter;
  var height = 200;
  var width = 220;
  if(counter == 0) {
    var h;
    var m_ceil = Math.ceil;
    var m_floor = Math.floor;
    for( var i=0; i < images.length; ++i) {
      var img_width = images[i].img.width;
      var img_height = images[i].img.height;
      if (img_height >= img_width) {
          width = m_floor(m_ceil(img_width / img_height * height));
      } else {
          height = m_floor(m_ceil(img_height / img_width * width));
      }
      if( (i+1) % 4 == 0){
        h = "<div class='span-6 last'>";
      } else {
        h = "<div class='span-6'>";
      }
      h += images[i].item + "<br/>";
      h += (images[i].tag != null ? images[i].tag : "&nbs;") + "<br/>";
      h += '<a href="' + images[i].src + '">';
      h += "<img src='" + images[i].src + "' height='" + height + "' width='" + width + "'/>";
      h += '</a>';
      h += "</div>";
      $('#images').append(h);
    }
    $('#images a').lightBox();
  }
}
$(function() {
  if(!!images) {
    for( var i=0; i < images.length; ++i) {
      images[i].img = new Image();
      images[i].img.src = images[i].src;
      images[i].img.onload= onload_images;
    }
  }
});
