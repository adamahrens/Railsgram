Dropzone.autoDiscover = false;

$(document).ready(function() {
  console.log('Document is ready');
  $(".post-upload").dropzone({
    addRemoveLinks:true,
    paramName: 'photo',
    autoProcessQueue: false,

    init: function(){
      var myDrop = this;
      console.log('Initing Dropzone');

      this.element.querySelector('#submit-post-button').addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        myDrop.processQueue();
      });

      this.on('success', function(file, response){
        window.location.reload();
      });

      this.on('error', function(file, response){
        toastr.error(response);
      });
    }
  });
});
