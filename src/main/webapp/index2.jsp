
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html  PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css_style_page2.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css_style.css">
        <link href='https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css'>

        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

		<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js'></script>
        <script src="${pageContext.request.contextPath}/js/functions.js"></script>
       <script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js" integrity="sha256-/H4YS+7aYb9kJ5OKhFYPUjSJdrtV6AeyJOtTkw6X72o=" crossorigin="anonymous"></script>
	    <script>
	    var cle_publique="";
	    /*< String id="";
	    try{
	    	if(session.getAttribute("state") == null){
	    		request.getRequestDispatcher("/index1.jsp").forward(request, response);
				return;
	    	}
	    	else{
	    		id=session.getAttribute("state").toString();
	    		if(!id.trim().equals("true")){
		    		request.getRequestDispatcher("/index1.jsp").forward(request, response);
	    		}
		    	session.removeAttribute("state");
	    	}
	    }
	    catch( Exception e){
	    	e.printStackTrace();
	    }

	    %>*/
	    
	    
	    	var indice2=0;
    $(function() {
        $("#sortable").sortable();
        $("#sortable").disableSelection();
    });
    function setparameters(){
    $("#next_button").prop("disabled",true);
    <%System.out.println("Génération de la clé publique du client...");%>
    get_public_key();
    
    }
    /*generating strings random*/
    function generate(length) {
        var result           = [];
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for ( var i = 0; i < length; i++ ) {
          result.push(characters.charAt(Math.floor(Math.random() * 
     charactersLength)));
       }
       return result.join('');
    }
    
    $(document).ready(function(){
    $('input[type=radio][name=flexRadioDefault]').change(function() {
       if ($("input[name='flexRadioDefault']:checked")) {
    	    $("#next_button").prop("disabled",false);
    	    if(document.getElementById("hidden_input").value!=""){
    	    	 if($('#constitution_liste').length){
    			}else{
    				principale= document.getElementById("constitution");
       				 div = document.createElement('div');
       				 div.setAttribute("id", "constitution_liste");
					 principale.appendChild(div);
    				}
    	    var id="#"+document.getElementById("hidden_input").value;
    	    $( "#next_button" ).click(function() {
			$("#constitution_liste").empty();
    	    $(id).each(function(){// id of ul
  			var li = $(this).find('li');//get each li in ul
    		var string=li.text();
    		var stringArray = string.split(/(\s+)/);
    		var nom_complet="";
    		var indice=0;

    		for (const element of stringArray) {
    			if(element.trim() !=""){
    				indice=parseInt(indice)+1;
    				nom_complet=nom_complet+element+" ";
    				if(parseInt(indice)==2){
						/*alert(nom_complet);*/
						div = document.createElement('div');
						input = document.createElement('input');
						label = document.createElement('label');

						div.setAttribute("class", "form-check form-switch");
						input.setAttribute("class", "form-check-input");
						input.setAttribute("type", "checkbox");
						input.setAttribute("checked", "checked");
						input.setAttribute("name", "condidats_choisis");
						label.setAttribute("class", "form-check-label");
						label.setAttribute("id", indice2);
						input.setAttribute("id", "input"+indice2);

					
div.appendChild(input);
div.appendChild(label);
document.getElementById("constitution_liste").appendChild(div);
$("#"+indice2.toString()).text(nom_complet);
indice2=parseInt(indice2)+1;
    					indice=0;
    					nom_complet="";
    				}
    			}
    			
    		}
    		
    		});
			});
    	  $( "#liste_choisis" ).text("Contenu de la Liste "+$("input[name='flexRadioDefault']:checked").val()+" :");
    	  			    $("#button_validate").prop("disabled",false);
    	$( "#minimum_choisis" ).text("Remarque : Vous devez choisir au minimim un candidat.");

    	  }
    	  else{  /*vote blanc*/
			
			refaire();
			$( "#liste_choisis" ).text("Aucune liste choisie, vous avez voté blanc.");
			    $("#button_validate").prop("disabled",false);
			    
    	  }
   }
   else{
   	 $("#next_button").prop("disabled",true);
   }
});
    });

    
    function get_public_key(){
    	$.ajax({
            type: "POST",
            url: "Generer_cryptage_Servlet",
            data: "generate=True",
            success: function(response) {
            	cle_publique=response.toString();
            	alert(cle_publique);
            }
        });
    }
    
    var myVar = setInterval(check_button_step2, 500);
    /*fonction qui permet de desactiver le bouton de la deuxième étape si aucun n'est choisis*/
    function check_button_step2() {
    	var nbr=$("input[type=checkbox]:checked").length;
    	if(parseInt(nbr) == 0){
        	$("#button_validate").prop("disabled",true);
        }
    	else{
        	$("#button_validate").prop("disabled",false);
    	}
    }
    $(document).on("click", "#button_validate", function() {  // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
    	var nbr=$("input[type=checkbox]:checked").length;
    
 /*   if(parseInt(nbr) == 0){
    	//$("#button_validate").prop("disabled",true);

    }
    else if (parseInt(nbr) > 0){ alert("ezz");*/
    	var liste=[];
    	var x = $('input[name="condidats_choisis"]');
    	if(x.length){ /*liste existe*/
    		$("input:checkbox[name=condidats_choisis]:checked").each(function () {
                liste.push($(this).next('label').text()+"-"+generate(5));
            });
    	}
    	else{ /*vote blanc*/
            liste.push("");

    	}
    	if(liste.length == 0){  /*dans le cas oû il choisit une liste puis décoche le tout*/
    		liste.push("");
    	}
    	
    	/*ici on chiffre avec la clé publique*/
    	/*on apelle le servlet avec "GET"  en utilisant AJAX  pour nous donner la clé publique*/
  get_public_key();
    		 
    	$.ajax({
            type: "POST",
            url: "Traiter_user_vote_Servlet",
            data: "liste="+JSON.stringify(liste),
            success: function(response) {
            	alert("hey");
            }
        });
    /*}*/
    });

/*supprimer dynamiquement les divs crée (liste) quand on click sur previous*/
    function refaire(){ 
/*for (i = indice2; i > 0; i--) {
$('#div'+i).remove();
$('#'+i).remove();
$('#input'+i).remove();*/
//$("#constitution_liste").empty();
$("#constitution_liste").remove();
			    $("#button_validate").prop("disabled",true);
			    $( "#minimum_choisis" ).empty();
/*}*/
indice2=0;
    }

    function sethidden(argument){
document.getElementById("hidden_input").value=argument;
    }
    
   
</script>
	<title>E-vote</title>
</head>
<body onload="setparameters()">
	<div class="container-fluid" >
    <div class="row justify-content-center">
        <div class="col-11 col-sm-9 col-md-7 col-lg-6 col-xl-5 text-center p-0 mt-3 mb-2"  style=" width: 60%; " >
            <div class="card px-0 pt-4 pb-0 mt-3 mb-3" >
                <h2 id="heading">Vote électronique</h2>
                <p>Remplissez tous les champs du formulaire pour passer à l'étape suivante</p>
                <form id="msform">
                    <!-- progressbar -->
                    <ul id="progressbar" >
                        <li class="active" id="bulletin"><strong>Constitution bulletin</strong></li>
                        <li id="vote"><strong>Vote</strong></li>
                        <li id="verification"><strong>Accusé de récéption</strong></li>

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
                                    <h2 class="steps" >Step 4 - 6</h2>
                                </div>
                            </div> 
<!--  icii-->
<div class="page-content page-container" id="page-content">
<p class="font-weight-bold" style="font-weight: bold;margin-left: 1rem;">Pour visualiser les candidats d'une liste, cliquez sur la liste associée.</p>


                <div class="container-fluid d-flex justify-content-center">
                    <div style="border:1px solid #673AB7;width: 55rem;" class="list list-row card" id="sortable" data-sortable-id="0" aria-dropeffect="move">
                        <div class="list-item" data-id="13" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false" style="">
                            <div><a href="images/Logo_du_front_de_libération_national_algérien.png" data-abc="true"><img class="w-40 avatar" src="images/Logo_du_front_de_libération_national_algérien.png" alt="Logo du front de libération national algérien"></a></div>
                            <div class="flex"> <a class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal">Liste A</a>
                                <div class="item-except text-muted text-sm h-1x">Front de libération nationale</div>
                                 <div class="item-except text-muted text-sm h-1x">جبهة التحرير الوطني</div>
                                 <div class="item-except text-muted text-sm h-1x">Tirni n Weslelli Aɣelnaw </div>


                            </div>
                           <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Liste des condidats de la liste A</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat A" id="A">
  <li class="person" style="color:red; font-weight: bold;"> Aline Ruqayyah</li>
  <li class="person" value=""> Ridwana Élodie</li>
  <li class="person" value=""> Tufayl Raheem</li>
   <li class="person" value=""> Valérie Bahiyya</li>
  <li class="person"> Qusay Rafiqa</li>
  <li class="person"> Fawziya Muatasim</li>
  <li class="person"> Rahma Samson</li>
    <li class="person"> Hasib Hanifa</li>

</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Centre gauche</div>
                            </div>
                            <div>
                            	
                                <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted">Profession de foi</a>
                                    
                            </div>   
                            </div>
                            <div style="max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" value="A" onclick="sethidden('A');">
  <label class="form-check-label" for="flexRadioDefault1">
   Choisir
  </label>
                             </div>
                        </div>
                        <div class="list-item" data-id="9" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false">
                            <div><a href="images/Logo_du_RND_Algérie.png" data-abc="true"><img class="w-40 avatar" src="images/Logo_du_RND_Algérie.png" alt="Logo du RND Algérie"></a></div>
                            <div class="flex"> <a href="#" class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal2">Liste B</a>
                                <div class="item-except text-muted text-sm h-1x">Rassemblement national démocratique</div>
                                <div class="item-except text-muted text-sm h-1x">التجمع الوطني الديمقراطي</div>
                                <div class="item-except text-muted text-sm h-1x">Agraw aɣelnaw amagday</div>

                            </div>
                             <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel2">Liste des condidats de la liste B</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat" id="B">
  <li class="person" style="color:red; font-weight: bold;"> Makram Widad</li>
  <li class="person"> Hasan Aisha</li>
  <li class="person"> Ziyad Habibullah</li>
   <li class="person"> Jamal alDin Noor</li>
  <li class="person"> Rabia Najma</li>
  <li class="person"> Asiya Dalal</li>
</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Centre droit</div>
                            </div>
                           <div>
                            	
                                <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted">Profession de foi</a>
                                    
                                </div>
                                 
                            </div>
                            <div style=" max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" value="B" onclick="sethidden('B');">
  <label class="form-check-label" for="flexRadioDefault2">
   Choisir
  </label>
                             </div>
                        </div>
                        <div class="list-item" data-id="17" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false" style="">
                            <div><a href="images/Logo_du_Rassemblement_de_l'espoir_de_l'Algérie.png" data-abc="true"><img class="w-40 avatar" src="images/Logo_du_Rassemblement_de_l'espoir_de_l'Algérie.png" alt="Logo du Rassemblement de l'espoir de l'Algérie"></a></div>
                            <div class="flex"> <a href="#" class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal3">Liste C</a>
                                <div class="item-except text-muted text-sm h-1x">Rassemblement de l'espoir de l'Algérie</div>
                                <div class="item-except text-muted text-sm h-1x">تجمع أمل الجزائر</div>
                                <div class="item-except text-muted text-sm h-1x">Agraw n Lamal n Lezzayer</div>
                            </div>
                               <div class="modal fade" id="exampleModal3" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel3">Liste des condidats de la liste C</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat" id="C">
  <li class="person" style="color:red; font-weight: bold;"> Rida Yacoub</li>
  <li class="person"> Yaqoob Waheeda</li>
  <li class="person"> Zulekha Shama</li>
   <li class="person"> Shakira Alya</li>
  <li class="person"> Saniyya Barack</li>
  <li class="person"> Sadaf Shafaqat</li>
</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Droite</div>
                            </div>
                            <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted">Profession de foi</a>
                                    
                                </div>
                                <div style=" max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3" value="C" onclick="sethidden('C');">
  <label class="form-check-label" for="flexRadioDefault3">
   Choisir
  </label>
                             </div>
                        </div>
                        <div class="list-item" data-id="8" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false">
                            <div><a href="images/Logo_du_Hamas_Algérien.png" data-abc="true"><img class="w-40 avatar" src="images/Logo_du_Hamas_Algérien.png" alt="Logo du Hamas Algérien"></a></div>
                            <div class="flex"> <a href="#" class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal4">Liste D</a>
                                <div class="item-except text-muted text-sm h-1x">Mouvement de la société pour la paix</div>
                                <div class="item-except text-muted text-sm h-1x">حماس الجزائر</div>
                                <div class="item-except text-muted text-sm h-1x">Ḥamas</div>

                            </div>
                            <div class="modal fade" id="exampleModal4" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel4">Liste des condidats de la liste D</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat" id="D">
  <li class="person" style="color:red; font-weight: bold;"> Riaz Husna</li>
  <li class="person"> Noura Sadaf</li>
  <li class="person"> Saleem Zaahir</li>
   <li class="person"> Jamillah Bilal</li>
  <li class="person"> Badr Mona</li>
  <li class="person"> Ismail Mohamed</li>

</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Droite</div>
                            </div>
                            <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted" >Profession de foi</a>
                                    
                                </div>
                                <div style=" max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault4" value="D" onclick="sethidden('D');">
  <label class="form-check-label" for="flexRadioDefault4">
   Choisir
  </label>
                             </div>
                        </div>
                        <div class="list-item" data-id="10" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false" style="">
                            <div><a href="images/El_Moustakbal_Logo_Algérie.png" data-abc="true"><img class="w-40 avatar" src="images/El_Moustakbal_Logo_Algérie.png" alt="El Moustakbal Logo Algérie"></a></div>
                            <div class="flex"> <a href="#" class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal5">Liste E</a>
                                <div class="item-except text-muted text-sm h-1x">Front El Moustakbal</div>
                                <div class="item-except text-muted text-sm h-1x">جبهة المستقبل</div>
                                <div class="item-except text-muted text-sm h-1x">Tirni n Lmusteqbel</div>

                            </div>
                             <div class="modal fade" id="exampleModal5" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel5">Liste des condidats de la liste E</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat" id="E">
  <li class="person" style="color:red; font-weight: bold;"> Noureddine Hassan</li>
  <li class="person"> Yahya Ibtihaj</li>
  <li class="person"> Dawood Koubra</li>
   <li class="person"> Safaa Amir</li>
  <li class="person"> Ayah Mokhtar</li>
  <li class="person"> Fizza Adrien</li>
  <li class="person"> Saniyya Mohammed</li>

</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Centre</div>
                            </div>
                           <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted" >Profession de foi</a>
                                    
                                </div>
                                <div style=" max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault5" value="E" onclick="sethidden('E');">
  <label class="form-check-label" for="flexRadioDefault5">
   Choisir
  </label>
                             </div>
                        </div>
                        <div class="list-item" data-id="3" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false">
                            <div><a href="images/Logo_du_Mouvement_populaire_algérien.png" data-abc="true"><img class="w-40 avatar" src="images/Logo_du_Mouvement_populaire_algérien.png" alt="Logo du Mouvement populaire algérien"></a></div>
                            <div class="flex"> <a href="#" class="item-author text-color" data-abc="true" data-toggle="modal" data-target="#exampleModal6">Liste F</a>
                                <div class="item-except text-muted text-sm h-1x">Mouvement populaire algérien</div>
                                <div class="item-except text-muted text-sm h-1x">الحركة الشعبية الجزائرية</div>
                                <div class="item-except text-muted text-sm h-1x">Amusu agdudan adzayri</div>


                            </div>
                             <div class="modal fade" id="exampleModal6" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel6">Liste des condidats de la liste F</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
     
<ol class="liste_condidat" id="F">
  <li class="person" style="color:red; font-weight: bold;"> Samira Haider</li>
  <li class="person"> Lilianne Noora</li>
  <li class="person"> Aurèle Morgane</li>
   <li class="person"> Alya Pharamond</li>
  <li class="person"> Anne Camélia</li>
  <li class="person"> Hasib Khaleel</li>
  <li class="person"> Adnan Rabil</li>


</ol> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
                            <div class="no-wrap">
                                <div class="item-date text-muted text-sm d-none d-md-block"><strong>Idéologie :</strong> Centre droit</div>
                            </div>
                          <div class="item-action"><center><div class="file_check"></div></center> <a href="C:\Users\YANIS\Desktop\work\autre\profession_foi.pdf" class="text-muted">Profession de foi</a>
                                    
                                </div>
                                <div style=" max-width:170px;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault6" value="F" onclick="sethidden('F');">
  <label class="form-check-label" for="flexRadioDefault6">
   Choisir
  </label>
                             </div>
                        </div>
                  
                   <div class="list-item" data-id="17" data-item-sortable-id="0" draggable="true" role="option" aria-grabbed="false" style="">
                     
                           
                                                   
                                <div style=" max-width:170px; margin-left:85%;">
<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault7" value="0" onclick="sethidden('');">
  <label class="form-check-label" for="flexRadioDefault7">
   <strong>Vote blanc</strong>
  </label>
                             </div>
                        </div>
                </div>
     
        </div>
    
</div>
                        </div> 
                        <input type="button" id="next_button" name="next" class="next action-button" value="Next" disabled="disabled"/>
                    </fieldset>
                     <fieldset>
                        <div class="form-card">
                            <div class="row">
                                <div class="col-7">
                                    <h2 class="fs-title" id="choix_fait1"></h2>
                                </div>
                                <div class="col-5">
                                    <h2 class="steps">Step 5 - 6</h2>
                                </div>
                            </div> 
                        <p id="liste_choisis" style="font-weight: bold; font-size: 20px;"></p>
                        <p id="minimum_choisis" style="font-weight: bold; font-size: 20px;"></p>
 <div id="constitution">
 <div id="constitution_liste">
 	
 	
 </div>
 </div>
<!-- ici-->

                        </div> 
                        <input type="button" id="button_validate" name="next" class="next action-button" value="Next" disabled="disabled" /> 
                        <input type="button" id="previous_buutton" name="previous" class="previous action-button-previous" value="Previous" onclick="refaire();" />
                    </fieldset>

                    <fieldset>
                        <div class="form-card">
                            <div class="row">
                                <div class="col-7">
                                    <h2 class="fs-title" id="choix_fait2"></h2>
                                </div>
                                <div class="col-5">
                                    <h2 class="steps">Step 6 - 6</h2>
                                </div>
                            </div> 
                            <!-- icii-->
                        </div> 
                        <input type="button" name="next" class="next action-button" value="Next" /> 
                        <input type="button" name="previous" class="previous action-button-previous" value="Previous" />
                    </fieldset>
                    <footer class="sticky-footer bg-white" id="foot">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; E-Vote Algérie 2021</span>
          </div>
        </div>
      </footer>
<input type="hidden" name="hidden" id="hidden_input" value="">
</body>
</html>
<style type="text/css">
    #progressbar li {
    width: 33%;
}
#hidden{
    display: none;
}

#progressbar #bulletin:before {
    font-family: FontAwesome;
    content: "\f0c5"
}

#progressbar #vote:before {
    font-family: FontAwesome;
    content: "\f2b5 "
}

 #progressbar #verification:before {
    font-family: FontAwesome;
    content: "\f00c "
}
.file_check:before {
    font-family: FontAwesome;
    content: "\f15c";
   font-size:2rem;
   /*margin-left: 1.2rem;*/

}
.person:before {
    font-family: FontAwesome;
    content: "\f007  "
}
.liste_condidat{
	list-style-type: none;
}
.modal-backdrop {
  z-index: -1;
}
</style>