// Get the modal IDs from layouts/partials/image_modal.html
var modal = document.getElementById("image_modal");
var modalImg = document.getElementById("image_modal_content_image");
var captionText = document.getElementById("image_modal_content_caption");

// Run imageModal function on any image that is clicked
var main = document.getElementById("main-content")
var images = main.getElementsByTagName("IMG");
for (var i = 0; i < images.length; i++) {
  images[i].addEventListener("click", imageModal);
}

// Get the image and insert it inside the modal - use its "alt" text as a caption
function imageModal(){
  modal.style.display = "block";
  modalImg.src = this.src;
  captionText.innerHTML = this.alt;
}

// When the user clicks on image_modal_close (x), close the modal
function closeImageModal() {
  modal.style.display = "none";
}
