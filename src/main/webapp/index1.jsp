<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html  PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css_style.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/functions.js"></script>
        <script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
        
	<title>
		E-vote
	</title>
</head>
<body onload="setparameters()">
<script type="text/javascript">
    <% 
 
    String message_err="";
    try{
    	if(request.getAttribute("privilege")!=null){
	       message_err=request.getAttribute("privilege").toString();
	 }
       if(!(message_err.isEmpty())){
       if(!message_err.equals("true")){
       %>				       
       Swal.fire({
           icon: 'error',
           title: 'Oops...',
           text: 'Accès refusé !',
	  		  confirmButtonColor: '#673AB7',

      })
      <% message_err="";
       request.removeAttribute("privilege");
       }}
    }catch(Exception e){}
   
    %>
    function setparameters(){

       /*  $('#fieldset4').hide();
        $("#fieldset4").css("display", "none");
         $('#fieldset5').hide();
        $("#fieldset5").css("display", "none");
        $('#fieldset6').hide();
        $("#fieldset6").css("display", "none");*/
        
        $('#next3').prop('disabled', true);
        $("#next3").css("display", "none");
    }
    function validate_choice(id){
        var choice = document.getElementById("hidden").value;
        if(!choice.trim()==""){
                    document.getElementById(choice).style.color="dark";
                    document.getElementById(choice).style.border = "0px solid white";
                    document.getElementById("hidden").value="";
        }
        if(choice == id){
                    document.getElementById(id).style.color="dark";
                    document.getElementById(id).style.border = "0px solid white";
                    document.getElementById("hidden").value="";
                    $("#button_validate").prop("disabled",true);

        }
        else{
        document.getElementById(id).style.color="#673AB7";
        document.getElementById(id).style.border = "2px solid #673AB7";
        document.getElementById("hidden").value=id;
        $("#button_validate").prop("disabled",false);
        }
     } 


function test(){
    var choix="";
    if(document.getElementById("hidden").value=="carte_national_choix"){
        choix="carte nationale";
        $("#carte_id_form").css("display", "block");

    }
    else if(document.getElementById("hidden").value=="carte_puce_choix"){
        choix="carte à puce";
        $("#carte_id_form").css("display", "none");
    }
    else if(document.getElementById("hidden").value=="cle_usb_choix"){
        choix="clé usb";
        $("#carte_id_form").css("display", "none");
    }
        $( "#choix_fait2" ).text($( "#choix_fait1" ).text()+" par "+choix);
    
    }
   /* interdire un rafraichissement de page*/
/*window.onbeforeunload = function() {
	
    String redirectURL = "Page_erreur.jsp";
    //response.sendRedirect(redirectURL);
    request.getRequestDispatcher(redirectURL).forward(request, response);//forwarding the request
%>
}
/*fonction ajax qui permet de vérifier la validitié du NIN inséré*/
$(document).on("click", "#button_carte_id", function() {  // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
	$('#modal_check_pin').modal('show');
/*	$.ajax({
        type: "POST",
        url: "Verifier_existance_carte_id_Servlet",
        data: "input="+JSON.stringify(document.getElementById("carte_id_input").value)+"&type_vote="+JSON.stringify($( "#choix_vote option:selected").text())+"&pin="+JSON.stringify(document.getElementById("pin_input").value),
        success: function(response) {       
        	if(response.toString()=="0"){ 

        		document.getElementById("id_pin").value=document.getElementById("carte_id_input").value;

        	}
        	else{
            	Swal.fire({
            		  icon: 'error',
            		  title: 'Oops...',
            		  text: 'Vous ne pourrez pas voter !'
            		})
            		$("#button_carte_id").prop("disabled",true);
		 			$("#next3").prop("disabled",true);
		 			document.getElementById("carte_id_input").readOnly = true;
		 			$("#carte_id_input").prop("readonly", true);


            	}
        }
    });*/
});

function check_pin(){
	 /* $( "#form_pin" ).submit();*/
		$.ajax({
        type: "POST",
        url: "Gerer_authentification_carte_id_Servlet",
        data: "input="+JSON.stringify(document.getElementById("carte_id_input").value)+"&type_vote="+JSON.stringify($( "#choix_vote option:selected").text())+"&pin="+JSON.stringify(document.getElementById("pin_input").value),
        success: function(response) {
        	if(response.toString()=="0"){
	 			$("#button_verif").prop("disabled",true);
	 			$("#pin_input").prop("readonly", true);

        		Swal.fire({
						position: 'center',
						 icon: 'success',
						title: 'Entrée Validée!',
						showConfirmButton: false,
						 timer: 2500
					})
                    $("#button_carte_id").prop("disabled",true);
    		 		$("#next3").prop("disabled",false);
    		 		document.getElementById("carte_id_input").readOnly = true;
		 			$("#carte_id_input").prop("readonly", true);
    		 		setTimeout(function(){
    		 			$( "#next3" ).click();
    		 			let timerInterval
    		 			Swal.fire({
    		 			  title: 'Redirection en cours..!',
    		 			  html: 'Patientez <b></b> milliseconds.',
    		 			  timer: 2000,
    		 			  timerProgressBar: true,
    		 			  didOpen: () => {
    		 			    Swal.showLoading()
    		 			    timerInterval = setInterval(() => {
    		 			      const content = Swal.getHtmlContainer()
    		 			      if (content) {
    		 			        const b = content.querySelector('b')
    		 			        if (b) {
    		 			          b.textContent = Swal.getTimerLeft()
    		 			        }
    		 			      }
    		 			    }, 100)
    		 			  },
    		 			  willClose: () => {
    		 			    clearInterval(timerInterval)
    		 			  }
    		 			}).then((result) => {
    		 			  if (result.dismiss === Swal.DismissReason.timer) {
    		 				 window.location.replace("/Plateforme_evote/index2.jsp");

    		 			  }
    		 			})
    		 	    }, 3000);
        	}
        	else{
        		Swal.fire({
          		  icon: 'error',
          		  title: 'Oops...',
          		  text: 'Vous ne pourrez pas votez !',
          		  footer : '<strong>Assuez vous d\'avoir saisi des informations correctes !</strong>'
          		})
          		$("#button_carte_id").prop("disabled",true);
		 			$("#next3").prop("disabled",true);
		 			$("#button_verif").prop("disabled",true);

		 			document.getElementById("carte_id_input").readOnly = true;
		 			$("#carte_id_input").prop("readonly", true);
		 			$("#pin_input").prop("readonly", true);
		 			$("#button_carte_id").prop("disabled",true);
        	}
        }
        });

}
function fun(){
    $("#check_integrity_vote").css("display", "none");

}
function fun2(){
    $("#check_integrity_vote").css("display", "inline-block");

}
</script>
<div class="container-fluid" >
    <div class="row justify-content-center">
        <div class="col-11 col-sm-9 col-md-7 col-lg-6 col-xl-5 text-center p-0 mt-3 mb-2"  style=" width: 50%;">
            <div class="card px-0 pt-4 pb-0 mt-3 mb-3" >
                <h2 id="heading">Vote électronique</h2>
                <p>Remplissez tous les champs du formulaire pour passer à l'étape suivante</p>
                <form id="msform">
                    <!-- progressbar -->
                    <ul id="progressbar" >
                        <li class="active" id="account"><strong>Choix élection</strong></li>
                        <li id="method"><strong>Méthode de vote</strong></li>
                        <li id="verification"><strong>Vérification</strong></li>
                        <li id="confirm"><strong>Validité</strong></li>
                    </ul>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
                    </div> <br> <!-- fieldsets -->
                    <fieldset>
                        <div class="form-card">
                            <div class="row">
                                <!--<div class="col-7">
                                    <h2 class="fs-title">Account Information:</h2>
                                </div>-->
                                <div class="col-12">
                                    <h2 class="steps" >Step 1 - 6</h2>
                                </div>
                            </div> 
            
<div class="form-group">
    <label for="exampleFormControlSelect1">Veuillez choisir l'élection législative vous correspondant : </label>
    <select class="form-control" id="choix_vote">
      <option disabled selected value="0">Choisir..</option>
      <option value="1">Élections présidentielles en Algérie 2021</option>
      <option value="2">Élections parlementaires en Algérie 2021</option>
      <option value="3">Élections sénatoriales du 29 juin 2021 en Algérie</option>
    </select>
  </div>


                            <!--<label class="fieldlabels">Email: *</label> <input type="email" name="email" placeholder="Email Id" /> <label class="fieldlabels">Username: *</label> <input type="text" name="uname" placeholder="UserName" /> <label class="fieldlabels">Password: *</label> <input type="password" name="pwd" placeholder="Password" /> <label class="fieldlabels">Confirm Password: *</label> <input type="password" name="cpwd" placeholder="Confirm Password" /> -->
                        </div> 
                        <input type="button" id="next_button" name="next" class="next action-button" value="Next" disabled="disabled" onclick="fun();"/>
                    </fieldset>
                     <fieldset>
                        <div class="form-card">
                            <div class="row">
                                <div class="col-7">
                                    <h2 class="fs-title" id="choix_fait1"></h2>
                                </div>
                                <div class="col-5">
                                    <h2 class="steps">Step 2 - 6</h2>
                                </div>
                            </div> 
                        
 

  
<div class="row row-cols-1 row-cols-md-3 g-4">
  <div class="col" id="carte_national_choix" name="choix_facon_vote" onclick="validate_choice(this.id)">
    <div class="card h-100">
      <img  class="card-img-top" src="images/carte_nationale_biometrique.jpg" alt="Card nationale biométrique">
      <div class="card-body">
        <h5 class="card-title">Vote par carte nationale</h5>
        <p class="card-text">Pour vérifier la disponibilité de votre carte nationale d'identité biométrique, veuillez introduire le Numéro d'Identification National “NIN” (voir image ci-dessous).</p>
      </div>
      <div class="card-footer">
        <a href="https://passeport.interieur.gov.dz/Fr/DemandeCNIBE_Fr/Demande%20carte%20national%20d'identit%c3%a9%20biom%c3%a9trique%20%c3%a9lectronique" target="_blank"><small class="text-muted">Demande de carte national</small></a>
      </div>
    </div>
  </div>
  <div class="col" id="carte_puce_choix" name="choix_facon_vote"  onclick="validate_choice(this.id)">
    <div class="card h-100">
      <img src="images/carte_puce.jpg" class="card-img-top" alt="Carte à puce">
      <div class="card-body">
        <h5 class="card-title">Vote par carte à puce</h5>
        <p class="card-text">Toutes les données nécessaires au vote sont rassemblées en un seul circuit intégré dans le microprocesseur de la puce .</p>
      </div>
      <div class="card-footer">
        <a ><small class="text-muted">Demande de carte à puce</small></a>
      </div>
    </div>
  </div>
  <div class="col" id="cle_usb_choix" name="choix_facon_vote"  onclick="validate_choice(this.id)">
    <div class="card h-100">
      <img src="images/usb.jpg" class="card-img-top" alt="Clé usb">
      <div class="card-body">
        <h5 class="card-title">Vote par clé usb authentifié</h5>
        <p class="card-text">Chaque individu est en sa posession, une clé usb dédié lui permettant un vote sécurisé et rapide.</p>
      </div>
      <div class="card-footer">
        <small class="text-muted">Comment en obtenir une ?</small>
      </div>
    </div>
  </div>
</div>

                        </div> 
                        <input type="button" id="button_validate" name="next" class="next action-button" value="Next" disabled="disabled" onclick="test();" /> 
                        <input type="button" name="previous" class="previous action-button-previous" value="Previous" onclick="fun2();"/>
                    </fieldset>

                    <fieldset>
                        <div class="form-card">
                            <div class="row">
                                <div class="col-7">
                                    <h2 class="fs-title" id="choix_fait2"></h2>
                                </div>
                                <div class="col-5">
                                    <h2 class="steps">Step 3 - 6</h2>
                                </div>
                            </div> 
                            <form id="formform">
                            <div id="carte_id_form" style="display: none;">
                             <!-- <form name="form" action="Verifier_existance_carte_id_Servlet" method="post" > -->
                          
                             <div class="input-group mb-3">
  								<input type="text" class="form-control" name="carte_id_entree" id="carte_id_input" placeholder="Saisir le code NIN de votre carte d'identité" aria-label="Saisir le code NIN de votre carte d'identité" aria-describedby="basic-addon2">
  								<div class="input-group-append">
    							<button class="btn btn-outline-secondary" id="button_carte_id" type="button" >Vérifier</button>
  								</div>
							</div>
                        <!--     </form> -->
                            </div>
                            </form>
                        </div> 
                        <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                        <input type="button" name="next" id="next3" class="next action-button" value="Next" disabled="disabled"/> 
                    
                    </fieldset>
                      <fieldset id="fieldset6" style="display: none;">
                        <div class="form-card">
                            <div class="row">
                                <div class="col-7">
                                    <h2 class="fs-title">Finish:</h2>
                                </div>
                                <div class="col-5">
                                    <h2 class="steps">Step 4 - 6</h2>
                                </div>
                            </div> <br><br>
                            <h2 class="purple-text text-center"><strong>SUCCESS !</strong></h2> <br>
                           
                          
                        </div>
                    </fieldset>
                             
                </form>
            </div>
        </div>
    </div>
    
</div>
<div class="container-fluid" >
    <div class="row justify-content-center">
     
<div class="col-11 col-sm-9 col-md-7 col-lg-6 col-xl-5 text-center p-0 mt-3 mb-2" id="check_integrity_vote" style="width:50%;">
<form class="form-inline">
 <div class="col-auto">
      <label class="sr-only" for="inlineFormInputGroup">Username</label>
      <div class="input-group mb-2">
        <div class="input-group-prepend">
          <div class="input-group-text">Avez-vous déjà voté ? vérifiez l'intégrté d'un vote !</div>
        </div>
        <input type="text" class="form-control" id="inlineFormInputGroup" placeholder="Saisir hash">
      </div>
    </div>
  <button type="submit" class="btn btn-outline-dark mb-2" style="float:right;">Vérifier</button>
</form>

<form class="form-inline" method="POST" action="Verifier_Personnel_Servlet">
 <div class="col-auto">
      <label class="sr-only" for="inlineFormInputGroup">Username</label>
      <div class="input-group mb-2">
        <div class="input-group-prepend">
          <div class="input-group-text">Êtes-vous un personnel de la plateforme ?</div>
        </div>
        <input type="password" class="form-control" name="code_pin" id="inlineFormInputGroup" placeholder="Saisir code secret">
      </div>
    </div>
  <button type="submit" class="btn btn-outline-dark mb-2" style="float:right;">Vérifier</button>
</form>
</div>
</div>
</div>
<input type="password" id="hidden" name="hidden" value="" hidden />
  <footer class="sticky-footer bg-white" id="foot">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; E-Vote Algérie 2021</span>
          </div>
        </div>
      </footer>

    
<div class="modal fade" id="modal_check_pin" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Vérification de l'identité</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="form_pin">
          <div class="form-group">
            <label for="recipient-pin" class="col-form-label">Veuillez saisir votre code PIN:</label>
            <input type="password" id="pin_input" name="pin" class="form-control" id="recipient-pin">
            <!-- <input type="hidden" name="id_pin" value="" id="id_pin"> -->
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-danger" data-dismiss="modal">Close</button>
        <button type="button" id="button_verif" class="btn btn-outline-dark" onclick="check_pin();">Vérifier</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>
<style type="text/css">
    #progressbar li {
    width: 25%;
}
#hidden{
    display: none;
}

#progressbar #account:before {
    font-family: FontAwesome;
    content: "\f13e"
}

#progressbar #personal:before {
    font-family: FontAwesome;
    content: "\f007"
}

#progressbar #payment:before {
    font-family: FontAwesome;
    content: "\f0e0"
}

#progressbar #confirm:before {
    font-family: FontAwesome;
    content: "\f00c"
}
#progressbar #method:before {
    font-family: FontAwesome;
    content: "\f0ae"
}
 #progressbar #verification:before {
    font-family: FontAwesome;
    content: "\f071"
}
</style>