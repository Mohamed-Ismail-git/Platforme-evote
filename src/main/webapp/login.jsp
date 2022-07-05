<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.css" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_login.css" /> 
    <!-- Sweet Alert JavaScript -->
    <script src="js/sweetalert2.js"></script>
 
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
   
  <!-- importer du javascript -->
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sweetalert2.js"></script>
            <script src="https://unpkg.com/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script> 
    <title>Log in | Plateforme E-vote</title>
    <script> 
<% 
if(session.getAttribute("privilege")!=null){
	if(!session.getAttribute("privilege").toString().equals("true")){
		request.getRequestDispatcher("/index1.jsp").forward(request, response);
	}
	else{
		session.removeAttribute("privilege");
	}
}
else{
	request.getRequestDispatcher("/index1.jsp").forward(request, response);
}
%>

function validate()
{ 
 var Email_Login = document.form.Email_Login.value; 
 var Password_Login = document.form.Password_Login.value;

 if (Email_Login==null || Email_Login=="")
 { 
 Swal.fire({
 icon: 'error',
 title: 'Oops...',
 text: 'Veuillez saisir votre code pin',
	  confirmButtonColor: '#673AB7',

})
 return false; 
 }
 else if(Password_Login==null || Password_Login=="")
 { 

 Swal.fire({
	 icon: 'error',
	 title: 'Oops...',
	 text: 'Veuillez saisir votre mot de passe',
		  confirmButtonColor: '#673AB7',

	})
 return false; 
 } 
}
function verif(){
	<%
	try{ String message_err="";
		if(request.getAttribute("infos_erreur")!=null){
	       message_err=request.getAttribute("infos_erreur").toString();
	 }
		 if(!(message_err.isEmpty())){%>				       
		 Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: 'Saisie erronée !',
			  confirmButtonColor: '#673AB7',

			})
	  <% message_err="";
	   request.removeAttribute("infos_erreur");
	   }
	}catch(Exception e){}
	%>
}
</script> 
</head>
<body class="bg-light" onload="verif();">
<form name="form" action="LoginServlet" method="post" onsubmit="return validate()">
    <div class="container-fluid">
        <div class="row mx-1">
            <div class="col-lg-10 col-md-10 offset-lg-1 offset-md-1 text-center mt-5 pb-4 text-custom">
                <i><h1 class="h1" style="color:#673AB7;">Plateforme E-Vote</h1></i>
            </div>
            <div class="col-lg-10 col-md-10 offset-lg-1 offset-md-1 bg-white shadow mb-5 border border-custom">
                <div class="row">
                    <div class="d-flex align-items-center col-lg-6 col-md-4 p-4 bg-custom divCover" style="background-color:white;border: 2px solid #673AB7;">
                        <img src="images/e-vote.jpg" alt="University Hat">
                    </div>
                    <div class="col-lg-6 col-md-6 p-lg-5 p-md-5 px-3 py-4">
                        <div id="signInForm">
                            <h2 class="h2 text-center text-custom mb-3" style="color:#673AB7;">Se connecter</h2>
                            <div class="form-group">
                                <label >Code id<span class="text-danger ml-1">*</span></label>
                                <input type="text" class="form-control" pattern="[0-9]*" name ="code_id_Login" placeholder="code id">
                                <small  class="form-text text-danger">Veuillez vérifier vos informations de connexion.</small>
                            </div>
                            <div class="form-group">
                                <label for="userSIPassword">Mot de Passe<span class="text-danger ml-1">*</span></label>
                                <input type="password" class="form-control" id="userSIPassword" name ="Password_Login" placeholder="password">
                                <small id="userSIPasswordError" class="form-text text-danger">Veuillez vérifier votre mot de passe.</small>
                             <!--   <small style="float:right"> <a href="Reset_Password.jsp" alt="refaire mdp"><strong class="text-custom text-uppercase showSignUpForm">Mot de passe oublié ?</strong></a></small>
                                -->
                            </div>
                            
                           
                            </div>
                            
                             <div style="padding-top:5px;float:right;">
                             <button type="submit" class="btn btn-outline-info btn-lg">S'identifier</button>
                             <button type="reset" class="btn btn-outline-danger btn-lg">Réinitialiser</button>
                             </div><br>
                       <!--      <p>Pas encore membre? En devenir un: <a href="index.jsp#utilisateurs"><strong class="text-custom text-uppercase showSignUpForm">S'enregistrer</strong></a></p>
                         --></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  <footer class="sticky-footer " id="foot">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; E-Vote Algérie 2021</span>
          </div>
        </div>
      </footer>
</form>
</body>
</html>
<style>
img { 
                max-width:100%; 
                /*height:auto; */
            } 
  .submitbutton{
  display: inline-block;
  padding: 6px 25px;
  font-size: 24px;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  outline: none;
  color: #fff;
  background-color: #673AB7;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}
 
 .submitbutton:hover {background-color: #673AB7;}

.submitbutton:active {
  background-color: #673AB7;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}

.resetbutton{
  display: inline-block;
  padding: 6px 25px;
  font-size: 24px;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  outline: none;
  color: #fff;
  background-color: #FA5858;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}
 
 .resetbutton:hover {background-color: #ff5555;}

.resetbutton:active {
  background-color: #FF0000;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
.bg-custom {
	background-color:#673AB7;
}
.text-custom{
	color:#00838f;
}
.border-custom{
	color:#00838f;
}
.btn-outline-info{
    color: #673AB7 !important;
    border: 1px solid #673AB7 !important;
}
.btn-outline-info:hover, .btn-outline-info:active, .btn-outline-info:visited {  /*changer couleur des buttons*/
	color:white !important;
	background-color:#673AB7;
}

</style>