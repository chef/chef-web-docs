// Get the modal
var modal = document.getElementById("image_modal");

// Get the image and insert it inside the modal - use its "alt" text as a caption
//var img = document.getElementsByTagName("IMG");
var images = document.getElementsByTagName("IMG");
for (var i = 0; i < images.length; i++) {
  images[i].addEventListener("click", imageModal);
}

function imageModal(){
  var modal = document.getElementById("image_modal");
  var modalImg = document.getElementById("image_modal_content_image");
  var captionText = document.getElementById("image_modal_content_caption");
  console.log('Display image')
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
}

// Get the <closeModal> element that closes the modal
var closeModal = document.getElementById("image_modal_close");

// When the user clicks on <closeModal> (x), close the modal
function closeImageModal() {
  modal.style.display = "none";
}