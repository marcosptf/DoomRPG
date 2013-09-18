<%-- 
    Document   : index
    Created on : 20/04/2012, 11:14:02
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doom Rpg</title>
        <script type="text/javascript" src="app/js/jquery-1.9.1.min.js"></script>
        <script type="text/javascript" src="app/js/validacao.class.js"></script>
        <script type="text/javascript" src="app/js/doomRpg.class.js"></script>
        <script type="text/javascript" src="app/js/doomRpg.js"></script>
        <link href="app/css/estilos.css" />
    </head>
    <body>
     <center>
        <fieldset id="conteiner" style="height:400px;padding-top:15px;padding-bottom:15px;position:relative;top:15px;width:500px;" >
            <legend>Game Doom RPG</legend>
            <div id="login">
                <br/>
                <br/>
                <label for="login">usuario</label>
                <input type="text"     id="login"  />
                <br/>
                <label for="senha">senha</label>
                <input type="password" id="senha"  />
                <br/>
                <br/>
                <input type="button"  id="entraGame" value="Entrar"  />
                <br/>
            </div>

            <div id="game1" style="display:none;">
                <span id="nomeGamer"></span>
                <span id="pontuacaoGamer"></span>
                <span id="vidaGamer"></span>
            </div>

        </fieldset>
     </center>
            <br/>
            <br/>
    </body>
</html>