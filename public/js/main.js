

window.onload = function() {
  $(".profileImage").on("click", function() {
    $(".profileDropdownContainer").css("display", "block")
    $(".screenCover").css("display", "block")
  })
  
  $(".searchInput").on("click", function() {
    $(".searchOptionContainer").css("display", "block")
    $(".screenCover").css("display", "block")
  })
  
  $(".screenCover").on("click", function() {
    $(".screenCover").css("display", "none")
    $(".profileDropdownContainer").css("display", "none")
    $(".searchOptionContainer").css("display", "none")
  })
  
  // let quill = new Quill('.editor', {
  //   modules: { 
  //     toolbar: [['code-block']]
  //   },
  //   theme: 'snow',
  //   readOnly: false
  // })
  
  // let quill = new Quill('.editor', {
  //   modules: { 
  //     toolbar: false
  //   },
  //   theme: 'snow',
  //   readOnly: true
  // })
  
  $(document).on("click", ".copyButton", function(){
    let elem = $(this).prev().children()
    
    let input = document.createElement("textarea")
    input.setAttribute('id', 'copyinput');
    document.body.appendChild(input);
    input.value = elem[0].innerText
    input.select();
    document.execCommand("copy")
    document.body.removeChild(input);
  })
}

