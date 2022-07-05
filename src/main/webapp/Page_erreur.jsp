<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font_face_Login.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style_erreur.css">

<title>Page d'erreur</title>
</head>
 <!-- importer du javascript -->
    <script src="javascript/jquery.min.js"></script>
    <script src='javascript/font_awesome.js'></script>
    <script src="javascript/bootstrap.min.js"></script>
        <script src="javascript/sweetalert2.js"></script>
            <script src="javascript/popper.min.js"></script>
      
    
<body>

    <div id="notfound">
		<div class="notfound">
			<div class="notfound-404"></div>
			<h1>404</h1>
			<h2>Oops! Page Introuvable</h2>
			<p>Désolé mais la page que vous recherchez n'existe pas,le nom a changé,vous n'avez pas une autorisation d'accès ou est temporairement indisponible.</p>
			<a href="/Plateforme_evote/">Revenir à l'acceuil</a>
		</div>
	</div>

</body>
</html>