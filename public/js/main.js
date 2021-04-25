

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
  

  $(document).on("click", ".likeButton", function() {
    let id = parseInt($(this).attr("id"))
    console.log($(this).css("background-color"))
    if ($(this).css("background-color") == "rgb(255, 255, 255)") {
      $(this).css("background-color", "rgb(239, 71, 111)")
      $(this).css("color", "rgb(255, 255, 255)")
    } else {
      $(this).css("background-color", "rgb(255, 255, 255)")
      $(this).css("color", "rgb(239, 71, 111)")
    }
    $.ajax("/like/" + id.toString(), {
    	type: "POST",
    	data: {},
    	datatype: "json"
    }).done (function(response) {
      
    }).fail (function(){
      if ($(this).css("background-color") == "white") {
        $(this).css("background-color", "rgb(239, 71, 111)")
        $(this).css("color", "white")
      } else {
        $(this).css("background-color", "white")
        $(this).css("color", "rgb(239, 71, 111)")
      }
    });
  })
  
  $(document).on("click", ".followButton", function() {
    let id = parseInt($(this).attr("id"))
    console.log($(this).css("background-color"))
    if ($(this).css("background-color") == "rgb(255, 255, 255)") {
      $(this).css("background-color", "rgb(239, 71, 111)")
      $(this).css("color", "rgb(255, 255, 255)")
    } else {
      $(this).css("background-color", "rgb(255, 255, 255)")
      $(this).css("color", "rgb(239, 71, 111)")
    }
    $.ajax("/follow/" + id.toString(), {
    	type: "POST",
    	data: {},
    	datatype: "json"
    }).done (function(response) {
      
    }).fail (function(){
      if ($(this).css("background-color") == "white") {
        $(this).css("background-color", "rgb(239, 71, 111)")
        $(this).css("color", "white")
      } else {
        $(this).css("background-color", "white")
        $(this).css("color", "rgb(239, 71, 111)")
      }
    });
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
  
  $(document).on("keydown", ".content", function(e) {
    if (e.key === "Tab") {
      e.preventDefault()
      
      var start = $(this)[0].selectionStart;
      var end = $(this)[0].selectionEnd;

      // set textarea value to: text before caret + tab + text after caret
      $(this).val($(this).val().substring(0, start)
                  + "\t"
                  + $(this).val().substring(end));

      // put caret at right position again
      this.selectionStart = start + 1;
      this.selectionEnd = start + 1;
    }
  })
}

